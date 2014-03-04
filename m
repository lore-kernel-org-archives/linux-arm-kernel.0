From: tharvey@gateworks.com (Tim Harvey)
Date: Mon, 3 Mar 2014 22:04:04 -0800
Subject: [PATCH 0/7] PCI irq mapping fixes and cleanups
In-Reply-To: <20140304000102.GC5603@obsidianresearch.com>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <CAJ+vNU2VN5haOU2GN5o7UUg9vgYh06pAhvDaoGw6EzTBEbD0mg@mail.gmail.com>
 <20140301183059.GA6315@obsidianresearch.com>
 <000601cf36b8$330b3a90$9921afb0$%han@samsung.com>
 <CAJ+vNU3UL+LTWnoxW7scAig19=z2xoYCA-HZ6a7GUyGEXtKK9Q@mail.gmail.com>
 <CAJ+vNU2ojt_o9=AOGfpbx6NCOE_kE6tsV8FvjoGYk9BBwP_OFQ@mail.gmail.com>
 <20140304000102.GC5603@obsidianresearch.com>
Message-ID: <CAJ+vNU2rR0+-tW9Z6M_1NNOagDNCGYE71ifPj_WryYjvnFY=Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 3, 2014 at 4:01 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Mon, Mar 03, 2014 at 03:40:43PM -0800, Tim Harvey wrote:
>
>> of_irq_parse_and_map_pci().  The GIC function that translates the
>> interrupt per domain is given irq_data: 0x123 0x04 0x00
>
> This has been shifted by 1 byte..
>
>> IRQ 123, which should get 32 added to it for irq155).  Instead, the
>> implementation of gic_irq_domain_xlate()
>> (http://lxr.missinglinkelectronics.com/linux/drivers/irqchip/irq-gic.c#L832)
>> adds 32 to the 0x04 returning 20:
>> [    1.841781] of_irq_parse_raw:  /soc/pcie at 0x01000000:00000001
>> [    1.841813] of_irq_parse_raw: ipar=/soc/pcie at 0x01000000, size=1
>> [    1.841838]  -> addrsize=3
>> [    1.841870]  -> match=1 (imaplen=28)
>                               ^^^^^^^^^^^^^
>
> That looks odd, it should be the number of dwords in the
> interrupt-map, you have 4 lines of 8 dwords each, so it should be
> 32.

(+cc Grant Likely)

imaplen does indeed get initialized to 32 (size of interrupt-map /
sizeof(u32)) but its printed above after its been decremented in the
loop which is misleading
(http://lxr.missinglinkelectronics.com/linux/drivers/of/irq.c#L201)

The issue appears to me to be a bug in of_irq_parse_raw() which has
been around since Graht's original commit:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/of/irq.c?id=7dc2e1134a22dc242175d5321c0c9e97d16eb87b

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 9bcf2cf..8829197 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -237,11 +237,11 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle
                        /* Check for malformed properties */
                        if (WARN_ON(newaddrsize + newintsize > MAX_PHANDLE_ARGS)
                                goto fail;
-                       if (imaplen < (newaddrsize + newintsize))
+                       if (imaplen < newintsize)
                                goto fail;

-                       imap += newaddrsize + newintsize;
-                       imaplen -= newaddrsize + newintsize;
+                       imap += newintsize;
+                       imaplen -= newintsize;

                        pr_debug(" -> imaplen=%d\n", imaplen);
                }

The issue is that the interrupt-map table point (imap) needs to be
incremented over the parent unit interrupt specifier which is
newintsize cells, not newaddrsize + newintsize cells.  The invalid
calculation would cause the pointer to get mis-aligned and thus only
the first interrupt entry would ever get properly checked for a match.

It looks like of_irq_parse_raw() is only called from
of_irq_parse_pci() which prior to Lucas' patch was only called from
pci_read_irq_line() called from pcibios_setup_device() used in
arch/arm/powerpc, so perhaps this function isn't widely used
explaining why the bug was never caught.

I'll post a patch shortly with the above fix.

<snip>

>> [    1.841972] irq_create_of_mapping: calling xlate for 123/4/0 3
>
> And it is the wrong data.. 123/4/0 is

right - this is shifted because of the issue above.

With the above patch Lucas' original patch now operates correctly to
resolve the 4 legacy PCI interrupts required when using a P2P bridge
on the IMX6.

Tim
