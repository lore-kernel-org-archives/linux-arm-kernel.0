From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 11 Dec 2011 19:53:42 -0500 (EST)
Subject: arm and patch phys offset
In-Reply-To: <201112112255.32534.michael@walle.cc>
References: <201112112255.32534.michael@walle.cc>
Message-ID: <alpine.LFD.2.02.1112111935590.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 11 Dec 2011, Michael Walle wrote:

> 
> [i don't know it this belongs to the arm kernel mailinglist]

It probably does, added.  When in doubt, it never hurt to CC the list.

> Hi Nico,
> 
> i'm facing some weird problem with the PATCH_PHYS_OFFSET config option 
> enabled.
> 
> I have a marvell kirkwood based LS-CHLv2 board and running the latest HEAD of 
> linus tree (with my dts patched for the kirkwood port, but hopefully this 
> should be unrelated to this problem).

Did you try without those patches to be sure?

> There seems to be p2v and v2p calls which aren't patched. Unfortunately i 
> don't have jtag access to the board. So, I use the following function to dump 
> non-patched entries of the pvtable (called from setup_arch()):
> 
> extern unsigned long __pv_table_begin, __pv_table_end;
> static void __init dump_pvtable(void)
> {
> 	unsigned char *b;
> 	unsigned long *cur = &__pv_table_begin;
> 	int i = 0;
> 	early_print("__pvtable %08lx..%08lx\n",
> 		&__pv_table_begin, &__pv_table_end);
> 	while (*cur) {

This is wrong.  You should have this instead:

	while (cur < &__pv_table_end) {

> 		b = (unsigned char *)(*cur);
> 		if (*b == 0x81) {
> 			early_print(" %d %08lx\n", i, *cur);
> 			/* uncommenting the following make the kernel work */
> 			/* *b = 0x40; */

Conceptually, this would be lacking a data vs insn cache 
resynchronization.

> 		    //early_print("   %08lx\n", *((unsigned long*)*cur));
> 		}
> 		cur++;
> 		i++;
> 	}
> 	early_print("total of %d entries\n", i);
> }
> 
> Now i get the following output:
> 
> Uncompressing Linux... done, booting the kernel.
> __pvtable c03f3e6c..c03f43c8
>  7 c03d8508                 
>  27 c03d9208
>  29 c03d9360
>  42 c03d9bfc
>  59 c03dd174
>  73 c03df094
>  77 c03df1b8
>  83 c03dfc54
>  85 c03dfe6c
>  127 c03e07d8
>  129 c03e11ac
> total of 343 entries
> 
> The weird thing is that this output changes if i insert or move some debug 
> prints. I even accomplished to make the board boot completely sometimes.

You must have some memory corrupting bug somewhere.  Please try calling 
this code first thing in start_kernel() for comparison.


Nicolas
