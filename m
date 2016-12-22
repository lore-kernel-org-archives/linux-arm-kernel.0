From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 22 Dec 2016 15:04:19 +0100
Subject: [PATCH] ARM: dts: imx: Pass an empty 'chosen' node
In-Reply-To: <f54f8c27-1745-ac30-4eb4-35e075877c08@osg.samsung.com>
References: <1482161298-32624-1-git-send-email-fabio.estevam@nxp.com>
 <CAOMZO5Be3f4YmGO0FJbeGZO55CJd9P9QO28SfhPLYuivtSHk7w@mail.gmail.com>
 <f54f8c27-1745-ac30-4eb4-35e075877c08@osg.samsung.com>
Message-ID: <201612221504.19941@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Monday 19 December 2016 22:44:40 Javier Martinez Canillas wrote:
> [adding Pali who first reported this issue]
> 
> Hello Pali,
> 
> On 12/19/2016 06:30 PM, Fabio Estevam wrote:
> > Hi Uwe,
> > 
> > On Mon, Dec 19, 2016 at 4:41 PM, Uwe Kleine-K?nig
> > 
> > <u.kleine-koenig@pengutronix.de> wrote:
> >> wouldn't it be better to fix the decompressor code to eventually
> >> create the /chosen node when it doesn't exist?
> > 
> > Thanks for the suggestion.
> > 
> > I don't have a Barebox setup handy, but would the following change
> > fix it as you propose?
> 
> Could you test Fabio's patch with NoLo to see if it fixes your issue?
> 
> I also think it makes more sense for Linux to create the "chosen"
> node if not present since this is a requirement due a Linux
> implementation detail.
> 
> Forcing to have a "chosen" node in dts leaks this implementation
> detail since the ePAPR document says that the "chosen" node should
> be optional.
> 
> > --- a/arch/arm/boot/compressed/atags_to_fdt.c
> > +++ b/arch/arm/boot/compressed/atags_to_fdt.c
> > @@ -66,13 +66,21 @@ static uint32_t get_cell_size(const void *fdt)
> > 
> >         return cell_size;
> >  
> >  }
> > 
> > -static void merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
> > +static int merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
> > 
> >  {
> >  
> >         char cmdline[COMMAND_LINE_SIZE];
> >         const char *fdt_bootargs;
> >         char *ptr = cmdline;
> > 
> > +       int chosen_off;
> > 
> >         int len = 0;
> > 
> > +       /* find or add chosen node */
> > +       chosen_off = fdt_path_offset(fdt, "/chosen");
> > +       if (chosen_off == -FDT_ERR_NOTFOUND)
> > +               chosen_off = fdt_add_subnode(fdt, 0, "chosen");
> > +       if (chosen_off < 0)
> > +               return chosen_off;
> > +
> > 
> >         /* copy the fdt command line into the buffer */
> >         fdt_bootargs = getprop(fdt, "/chosen", "bootargs", &len);
> >         if (fdt_bootargs)

This patch looks wrong. The next if condition is there to read 
/chosen/boootargs entry because this function merge_fdt_bootargs() is 
merging them together. And for reading bootargs you do not need to 
create /chosen node, if it does not exists above getprop() returns NULL 
and next if correctly handles it (= no bootargs for merging).

But setting /chosen/bootargs is also outside of this function in 
atags_to_fdt() where merge_fdt_bootargs() does not have to be called (in 
case do_extend_cmdline is not truth).

So this patch does not fix real problem, 'chosen' node does not have to 
exist even after applying this patch.

I'm for fixing this uncompressor code so 'chosen' stay optional (as 
written in that ePAPR document) and Linux kernel uncompressor correctly 
creates it. But this patch is not doing it (correctly).

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161222/ebc24098/attachment-0001.sig>
