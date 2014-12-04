From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 4 Dec 2014 18:57:48 +0100
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <CAL_JsqKYpDD1Rq2n92FcspPWGJeQvtA4eRYPDK=xYPQN0=uQTg@mail.gmail.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201412040148.31033@pali>
 <CAL_JsqKYpDD1Rq2n92FcspPWGJeQvtA4eRYPDK=xYPQN0=uQTg@mail.gmail.com>
Message-ID: <201412041857.49341@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 December 2014 17:49:40 Rob Herring wrote:
> On Wed, Dec 3, 2014 at 6:48 PM, Pali Roh?r 
<pali.rohar@gmail.com> wrote:
> > On Thursday 04 December 2014 01:33:08 Rob Herring wrote:
> >> On Mon, Nov 24, 2014 at 4:19 PM, Pali Roh?r
> > 
> > <pali.rohar@gmail.com> wrote:
> >> > On Wednesday 18 June 2014 22:46:19 Rob Herring wrote:
> >> >> On Wed, Jun 18, 2014 at 2:22 PM, Pali Roh?r
> >> > 
> >> > <pali.rohar@gmail.com> wrote:
> >> >> > On Wednesday 18 June 2014 21:07:35 Rob Herring wrote:
> >> >> >> On Wed, Jun 18, 2014 at 11:54 AM, Pali Roh?r
> >> >> > 
> >> >> > <pali.rohar@gmail.com> wrote:
> >> >> >> > Machine name from board description is some generic
> >> >> >> > name on DT kernel. DT provides machine name
> >> >> >> > property which is specific for board, so use it
> >> >> >> > instead generic one when possible.
> >> 
> >> [...]
> >> 
> >> >> > Basically in DT kernel is missing Hardware, Revision
> >> >> > and probably also Serial key. (Now I used only qemu
> >> >> > for testing which set serial key to 0). All these
> >> >> > informations is used by userspace applications which
> >> >> > determinate how to behave.
> >> >> 
> >> >> It is somewhat fragile to expect the name in the DT to
> >> >> match the old name from the kernel. As your patch to
> >> >> n900 dts shows, we'd probably have to update every dts
> >> >> file to make them match. While I think we should work
> >> >> to remove this string from the kernel, userspace
> >> >> depending on the DT model string is a bad idea. For
> >> >> example, if you had some platform with multiple OEMs
> >> >> just rebranding the same base design, they may all want
> >> >> to put their own model string into each product. The
> >> >> true h/w id is the compatible string.
> >> >> 
> >> >> Serial number is easy. There is already a standard
> >> >> although not widely used property for it with
> >> >> "/serial-number". You just need to wire it up to
> >> >> cpuinfo.
> >> > 
> >> > There is no "/serial-number" property in kernel:
> >> > 
> >> > $ ls -l -a /sys/bus/soc/devices/soc0/
> >> > drwxr-xr-x    3 0        0                0 Jan  1 00:00
> >> > . drwxr-xr-x   18 0        0                0 Jan  1
> >> > 00:00 .. -r--r--r--    1 0        0             4096 Jan
> >> >  1 00:00 family -r--r--r--    1 0        0            
> >> > 4096 Jan  1 00:00 machine drwxr-xr-x    2 0        0    
> >> >            0 Jan  1 00:00 power -r--r--r--    1 0       
> >> > 0
> >> > 4096 Jan  1 00:00 revision lrwxrwxrwx    1 0        0
> >> > 
> >> >          0 Jan  1 00:00 subsystem -> ../../bus/soc
> >> > 
> >> > -r--r--r--    1 0        0             4096 Jan  1 00:00
> >> > type -rw-r--r--    1 0        0             4096 Jan  1
> >> > 00:00 uevent
> >> 
> >> Wrong place. If you put /serial-number in your DT, then it
> >> will be in /proc/device-tree/serial-number.
> >> 
> >> If you want to wire that up to /proc/cpuinfo, I would be
> >> fine with that.
> >> 
> >> Rob
> > 
> > I cannot hardcode it into DT, because it is set by
> > bootloader. And bootloader tell it to kernel via ATAGs
> > structure. Bootloader is closed and proprietary and cannot
> > be replaced (there is no documentation for hw init).
> 
> Either the bootloader can put the serial number into the DTB
> instead of ATAGs or the kernel decompressor can copy it from
> ATAGs to DTB like is done already for other ATAGs. I presume
> you cannot update the bootloader and will need the latter.
> 
> Rob

Rob, thanks for info! Btw, theoretically I can update bootloader 
if someone write it. So in practise I need to use second option.

Can you tell me which CONFIG_ needs to be enabled for kernel 
decompressor (so it copy some ATAGs) and where to start looking 
at code (for adding new code for copying other ATAGs)?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/fa7d9132/attachment-0001.sig>
