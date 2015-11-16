From: computersforpeace@gmail.com (Brian Norris)
Date: Sun, 15 Nov 2015 20:12:44 -0800
Subject: [PATCH 1/3] mtd: create a partition type device tree binding
In-Reply-To: <CACRpkdakyae95f_Lc-R7Uf7wndj5hyfCqqHziwmZjwm-uNkGAg@mail.gmail.com>
References: <1446123152-22666-1-git-send-email-linus.walleij@linaro.org>
 <20151029162908.GA13275@localhost>
 <CACRpkdYS5Jf8UC2K0bNdEQZDjTeZZx44Uu-kkof+9E=4Ny0oDg@mail.gmail.com>
 <20151030175145.GF13239@google.com>
 <CAL_JsqL2F3p7qBPbOiGytVyzF_aNLWbrCT0mAX1WZo6SxE3JoA@mail.gmail.com>
 <20151113220039.GA74382@google.com>
 <CACRpkdakyae95f_Lc-R7Uf7wndj5hyfCqqHziwmZjwm-uNkGAg@mail.gmail.com>
Message-ID: <20151116041244.GA4021@brian-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 14, 2015 at 11:46:59AM +0100, Linus Walleij wrote:
> On Fri, Nov 13, 2015 at 11:00 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
> 
> (...)
> >  (2) we should define a comptible property for the hard-coded
> >  partitioning case (e.g., compatible = "partitions")
> (...)
> > If we went with option (2), then ofpart.c could just check only for
> > 'compatible = "partitions"' (or similar), and if not found bail out.
> 
> So this "hard-coded partitioning case" the case is where all partitions
> are defined in the device tree as described in
> Documentation/devicetree/bindings/mtd/partition.txt ?

Right.

> Or is it a way to indicate that this array
> static const char * const part_probe_types_def[] = {
>         "cmdlinepart", "RedBoot", "ofpart", "ofoldpart", NULL };
> in physmap_of.c should be used?

No. At this point, I would consider that to be a legacy method. We still
have to support this for many cases (including the non-DT case; but
hopefully we can do better than that soon), and that would be an option.

> Sorry if I don't fully follow, I'm a bit stupid when it comes to the MTD
> helicopter  view of the situation.... :(

Yeah...sorry if I wasn't too clear. And I definitely don't blame you for
not understanding the mess that MTD often is :(

> > I think option (2) makes more sense. But it would require an update to
> > the binding and code for 4.4, since [1] was only introduced during this
> > release cycle.
> 
> Does that mean all old device trees that specify no compatible
> string all of a sudden stop working? We can't break the DT ABI, so I
> guess not.

No, that's not what I was intending. The binding before commmit
fe2585e9c29a ("doc: dt: mtd: support partitions in a special
'partitions' subnode") should still stay working as-is. That is, we
don't mess with the way things worked for anything that doesn't have a
'partitions' subnode. But now that we have a 'partitions' subnode (in
4.4-rc1), I'm just suggesting that we enforce this always have a
compatible property, so we can be more clear on the difference between:

	partitions {
		// do I have a
		// compatible = "partitons";
		// here?

		partition at 0 {
			label = "foo-partition";
			reg = <0 0x100000>;
		};
	};

and

	partitions {
		compatible = "arm,arm-flash-structure";

		subnode {
			// what if we need something here eventually?
		};
	};

This would require some modifications to partitions.txt and to
drivers/mtd/ofpart.c.

> A bit confused here, I can't really see what I should do with the patch...

Hopefully that cleared up a bit? The code changes for my suggestion
would just be something like this, I think. (Not tested in any way.)

diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
index 669c3452f278..6811bc5440a4 100644
--- a/drivers/mtd/ofpart.c
+++ b/drivers/mtd/ofpart.c
@@ -50,6 +50,10 @@ static int parse_ofpart_partitions(struct mtd_info *master,
 			master->name, mtd_node->full_name);
 		ofpart_node = mtd_node;
 		dedicated = false;
+	} else {
+		/* The "partitions" subnode may belong to some other parser */
+		if (!of_device_is_compatible(ofpart_node, "partitions"))
+			return 0;
 	}
 
 	/* First count the subnodes */

I was just bringing this up for discussion, since it's related to
your/Rob's new proposal. I'll send a proper (and tested) patch, along
with a doc update, if that looks reasonable.

Brian
