From: francesco.virlinzi@st.com (Francesco VIRLINZI)
Date: Tue, 12 Jan 2010 09:48:44 +0100
Subject: [RFC,PATCH 1/7 v2] Add a common struct clk
In-Reply-To: <1263279511.160551.332624337260.1.gpush@pororo>
References: <1263279511.160551.332624337260.1.gpush@pororo>
Message-ID: <4B4C376C.6080705@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy
In November I already sent a proposal on
  a generic linux clk framework.
On that I would suggest:

>
> +struct clk {
> +	const struct clk_operations *ops;
>    
            spinlock_t lock;
            const char *name;
            int id;
            unsigned long rate;
> +};
> +
> +struct clk_operations {
>    
                int (*init)(struc clk *);
> +       int             (*enable)(struct clk *);
> +       void            (*disable)(struct clk *);
> +       unsigned long   (*get_rate)(struct clk *);
> +       void            (*put)(struct clk *);
> +       long            (*round_rate)(struct clk *, unsigned long);
> +       int             (*set_rate)(struct clk *, unsigned long);
> +       int             (*set_parent)(struct clk *, struct clk *);
> +       struct clk*     (*get_parent)(struct clk *);
> +};
>    

+static inline int clk_enable(struct clk *clk)
+{
	unsigned long flags;
	int ret = 0;
+	if (clk->ops->enable) {
		spinlock_irq_save(&clk->lock, flags);
+		ret = clk->ops->enable(clk);
		spinlock_irq_restore(&clk->lock, flags);
	}
+	return 0;
+}

Something similar in the other function...

> +
> +static inline unsigned long clk_get_rate(struct clk *clk)
> +{
> +	if (clk->ops->get_rate)
> +		return clk->ops->get_rate(clk);
>    
> 	return clk->rate;
> +}
>
>    
Moreover if you support .set_parent and .get_parent  a .parent field in 
the struct clk
  is useful.

As

struct clk {
const struct clk_operations *ops;

     spinlock_t lock;
     const char *name;
     int id;
     unsigned long rate;
     struct clk *parent;
};

Regards
  Francesco
