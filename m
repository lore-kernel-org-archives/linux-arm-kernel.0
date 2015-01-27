From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Tue, 27 Jan 2015 15:32:25 +0100
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <CAL_JsqKM+2PtX_EpWXyOQHVXwf=jqVj8SroUGPO1Y2=Zj8_kMg@mail.gmail.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <20150127132127.GA869@amd>
 <CAL_JsqKM+2PtX_EpWXyOQHVXwf=jqVj8SroUGPO1Y2=Zj8_kMg@mail.gmail.com>
Message-ID: <201501271532.25540@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 January 2015 15:16:45 Rob Herring wrote:
> On Tue, Jan 27, 2015 at 7:21 AM, Pavel Machek <pavel@ucw.cz> 
wrote:
> > On Mon 2015-01-26 14:33:21, Rob Herring wrote:
> >> On Mon, Jan 26, 2015 at 1:16 PM, Pali Roh?r 
<pali.rohar@gmail.com> wrote:
> >> > This patch will cause that decompressor store full ATAG
> >> > structure into DT tree ("/atags"):
> >> > 
> >> > 
> >> > +       /* include the terminating ATAG_NONE */
> >> > +       atag_size = (char *)atag - (char *)atag_list +
> >> > sizeof(struct tag_header); +       setprop(fdt, "/",
> >> > "atags", atag_list, atag_size); +
> >> > 
> >> >         if (memcount) {
> >> >         
> >> >                 setprop(fdt, "/memory", "reg",
> >> >                 mem_reg_property,
> >> >                 
> >> >                         4 * memcount * memsize);
> >> > 
> >> > And this patch will export ATAG structure from DT tree 
("/atags") into /proc/atags file:
> >> Please properly send your patches.
> > 
> > Actually, when sending patches for discussion, this is
> > format easier to read.
> 
> Some people might prefer them as attachments too...
> 
> >> > Some userspace applications needs access to ATAG
> >> > structure where can be stored some information passed
> >> > from bootloader to kernel. Example is Nokia N900 device
> >> > and NOLO bootloader which provides information about
> >> > bootreason (device was started by power button or by
> >> > alarm or restarted...) and bootmode (normal mode or
> >> > device update mode).
> >> 
> >> This goes in the commit message.
> >> 
> >> These would be non-standard fields which are not upstream.
> >> I don't know that we care in that case...
> > 
> > Other devices are going to care about boot reason, too, and
> > we might as well be compatible...
> 
> What other devices? Where is bootreason in the list of ATAGS:
> 
> #define ATAG_MEM        0x54410002
> #define ATAG_VIDEOTEXT  0x54410003
> #define ATAG_RAMDISK    0x54410004
> #define ATAG_INITRD     0x54410005
> #define ATAG_INITRD2    0x54420005
> #define ATAG_SERIAL     0x54410006
> #define ATAG_REVISION   0x54410007
> #define ATAG_VIDEOLFB   0x54410008
> #define ATAG_CMDLINE    0x54410009
> #define ATAG_ACORN      0x41000101
> #define ATAG_MEMCLK     0x41000402
> 
> Rob

Each device is using own proprietary atag (or other information) 
to pass bootreason from bootloader to kernel. No standard way :-(

I think Pavel mean to introduce some standard way how *new* 
version of bootloaders can pass boot reason to kernel and how 
kernel tell it to userspace...

E.g. NOLO -- bootloader for Nokia N900 -- pass this information 
in ATAG_OMAP (0x414f4d50) and Nokia kernel exports it via procfs 
file /proc/bootreason.

Also NOLO pass some other information via ATAGs, but those are 
static and now part of n900 DT file. But bootreason is not static 
information so cannot be hardcoded into static DT file which is 
part of kernel.

I think this kind of information (how was board/computer started) 
can be useful also for other architectures. E.g. on laptop you 
would like to know if if was started by RTC, power button, 
WakeOnLan, another ACPI event, rebooted machine, watchdog, etc... 
And scripts can act depending on this event (when by RTC, you 
need to run some planned job, when by watchdog reset you should 
check what caused that reason...).

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/f0b0c2da/attachment.sig>
