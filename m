From: grant.likely@linaro.org (Grant Likely)
Date: Mon, 20 Jan 2014 22:47:42 +0000
Subject: [RFC PATCH 1/1] of/irq: create interrupts-extended-2 property
In-Reply-To: <20140115161224.GH25824@e106331-lin.cambridge.arm.com>
References: <1389786445-10598-1-git-send-email-plagnioj@jcrosoft.com> <
 20140115121750.GE25824@e106331-lin.cambridge.arm.com> <20140115124041.
 GD9558@ns203013.ovh.net> <20140115134653.GF25824@e106331-lin.cambridge.arm.
 com> <20140115161224.GH25824@e106331-lin.cambridge.arm.com>
Message-ID: <20140120224742.EC905C40B12@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jan 2014 16:12:24 +0000, Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > Another, more invasive option would be extend the dts syntax and teach
> > dtc to handle property appending. Then the soc dts could stay as it is,
> > and the board dts could have something like:
> > 
> > 	/append-property/ interrupts = <&intc1 6 1>;
> > 	/append-property/ interrupt-names = "board-specific-irq";
> > 
> > Both these options solve the issue at the source, are general to other
> > properties, and allow more than one level of hierarchy (the proposed
> > interrupts-extended-2 only allows one level).
> 
> I've just had a go at implementing the append-property mechanism above
> in dtc, and it was far easier than I expected (patch below).
> 
> Does anyone have any issues with the /append-property/ idea?

I think that is reasonable.

g.

> 
> Thanks,
> Mark.
> 
> ---->8----
> 
> From 88be0036b6a966bd7506f58e3cb9ce9ea4c5ac48 Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Wed, 15 Jan 2014 15:43:51 +0000
> Subject: [PATCH] dtc: add ability to append properties
> 
> When dealing with hierarchies of dtsi files, handling minute differences
> between individual boards can become very painful. Adding a single
> board-specific interrupt requires duplicating the entire interrupts
> property, which requires duplication of common values. This makes bug
> fixing painful and if not handled very carefully files diverge rapdily.
> 
> To ameliorate this, this patch adds the ability to append properties,
> allowing board files to describe only the additional values required in
> a property. This functionality also works with strings, so parallel
> properties like interupts and interrupt-names stay in sync. Properties
> may be appended multiple times, and deleting properties clears all
> previous appended values.
> 
> To append a property, secondary definitions must be prefixed with
> /append-property/. This is longer than a possible '+=' syntax, but makes
> it far easier to spot when appending behaviour is requested, and so
> hopefully will lead to fewer buggy dts files.
> 
> For example, if the following dts fragements are compiled together:
> 
>   / {
>       interrupts = <0>, <1>;
>       interrupt-names = "zero", "one";
>   };
> 
>   / {
>       /append-property/ interrupts = <2>, <3>;
>       /append-property/ interrupt-names = "two", "three";
>   };
> 
> They will result in a dtb equivalent to the following dts fragment:
> 
>   / {
>       interrupts = <0>, <1>, <2>, <3>;
>       interrupt-names = "zero", "one", "two", "three";
>   };
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  dtc-lexer.l  |  7 +++++++
>  dtc-parser.y |  5 +++++
>  dtc.h        |  2 ++
>  livetree.c   | 15 ++++++++++++++-
>  4 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/dtc-lexer.l b/dtc-lexer.l
> index 0cd7e67..7989abe 100644
> --- a/dtc-lexer.l
> +++ b/dtc-lexer.l
> @@ -131,6 +131,13 @@ static bool pop_input_file(void);
>  			return DT_DEL_PROP;
>  		}
>  
> +<*>"/append-property/"	{
> +			DPRINT("Keyword: /append-property/\n");
> +			DPRINT("<PROPNODENAME>\n");
> +			BEGIN(PROPNODENAME);
> +			return DT_APPEND_PROP;
> +		}
> +
>  <*>"/delete-node/"	{
>  			DPRINT("Keyword: /delete-node/\n");
>  			DPRINT("<PROPNODENAME>\n");
> diff --git a/dtc-parser.y b/dtc-parser.y
> index 4864631..a8409ed 100644
> --- a/dtc-parser.y
> +++ b/dtc-parser.y
> @@ -63,6 +63,7 @@ static unsigned char eval_char_literal(const char *s);
>  %token DT_LSHIFT DT_RSHIFT DT_LE DT_GE DT_EQ DT_NE DT_AND DT_OR
>  %token DT_BITS
>  %token DT_DEL_PROP
> +%token DT_APPEND_PROP
>  %token DT_DEL_NODE
>  %token <propnodename> DT_PROPNODENAME
>  %token <literal> DT_LITERAL
> @@ -195,6 +196,10 @@ propdef:
>  		{
>  			$$ = build_property($1, empty_data);
>  		}
> +	| DT_APPEND_PROP DT_PROPNODENAME '=' propdata ';'
> +		{
> +			$$ = build_property_append($2, $4);
> +		}
>  	| DT_DEL_PROP DT_PROPNODENAME ';'
>  		{
>  			$$ = build_property_delete($2);
> diff --git a/dtc.h b/dtc.h
> index 20e4d56..8687530 100644
> --- a/dtc.h
> +++ b/dtc.h
> @@ -133,6 +133,7 @@ struct label {
>  };
>  
>  struct property {
> +	bool appended;
>  	bool deleted;
>  	char *name;
>  	struct data val;
> @@ -186,6 +187,7 @@ void delete_labels(struct label **labels);
>  
>  struct property *build_property(char *name, struct data val);
>  struct property *build_property_delete(char *name);
> +struct property *build_property_append(char *name, struct data val);
>  struct property *chain_property(struct property *first, struct property *list);
>  struct property *reverse_properties(struct property *first);
>  
> diff --git a/livetree.c b/livetree.c
> index b61465f..894e42b 100644
> --- a/livetree.c
> +++ b/livetree.c
> @@ -74,6 +74,15 @@ struct property *build_property_delete(char *name)
>  	return new;
>  }
>  
> +struct property *build_property_append(char *name, struct data val)
> +{
> +	struct property *new = build_property(name, val);
> +
> +	new->appended = 1;
> +
> +	return new;
> +}
> +
>  struct property *chain_property(struct property *first, struct property *list)
>  {
>  	assert(first->next == NULL);
> @@ -167,7 +176,11 @@ struct node *merge_nodes(struct node *old_node, struct node *new_node)
>  				for_each_label_withdel(new_prop->labels, l)
>  					add_label(&old_prop->labels, l->label);
>  
> -				old_prop->val = new_prop->val;
> +				if (new_prop->appended)
> +					old_prop->val = data_merge(old_prop->val, new_prop->val);
> +				else
> +					old_prop->val = new_prop->val;
> +
>  				old_prop->deleted = 0;
>  				free(new_prop);
>  				new_prop = NULL;
> -- 
> 1.8.1.1
> 
