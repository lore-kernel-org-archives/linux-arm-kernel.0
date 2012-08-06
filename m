From: klightspeed@killerwolves.net (Ben Peddell)
Date: Mon, 06 Aug 2012 19:25:09 +1000
Subject: problems with external initramfs passed to device tree kernel
In-Reply-To: <CAB9O=CMADa26benQCkEoLOKKTGNeExjvFeVkFe4HLVi-W=o=Jg@mail.gmail.com>
References: <CAB9O=CMADa26benQCkEoLOKKTGNeExjvFeVkFe4HLVi-W=o=Jg@mail.gmail.com>
Message-ID: <501F8D75.8070108@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/2012 9:12 AM, John Linn wrote:
> I'm not sure this is specific to ARM, but that's what I'm on so I 
> thought I'd ask.  I'm also running a device tree kernel.  I've
> tried it on 3.0 and 3.3 kernels.
> 
> I'm seeing where I have to remove CONFIG_BLK_DEV_RAM from the
> kernel to get it to boot with an external initramfs image. It says
> the image is not?good (junk in it), but it boots.  The same image
> boots fine when built into the kernel using INITRAMFS_SOURCE, even
> with BLK_DEV_RAM in the kernel.
> 
> I've done quite a bit of digging at the init/initramfs.c and it's
> not obvious to me where the issue lies (user error probably).
> 
> Any thoughts would be appreciated.

If the size of the initramfs image is set in either devicetree or the
initrd= kernel parameter, and is larger than the actual initramfs
image is, then the kernel throws the image away if it's followed by
anything other than null bytes.  U-boot doesn't initialize the RAM to
zeroes, so the initramfs will be followed by whatever was in RAM -
usually 0xFF with zero bits here and there, or the decayed contents
before the previous shutdown if the machine was off for a very short time.

I will follow up with a patch that should remedy this issue.  Please
let me know if there's a better way to do this.

-- 
Ben Peddell
IT Support Bowen, Collinsville and Proserpine Catholic schools
http://klightspeed.killerwolves.net/
