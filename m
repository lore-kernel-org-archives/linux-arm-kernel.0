From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 23 Feb 2016 14:45:30 +0200
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
Message-ID: <56CC546A.9070705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/02/16 13:56, Peter Maydell wrote:
> On 23 February 2016 at 09:58, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> I'm not quite sure how it works if, as in versatile display case, there
>> are multiple DT overlays of which one has to be enabled. I hope there's
>> support to choose which one to use via kernel cmdline or similar.
>>
>> I would personally like it much more if the bootloader would either
>> compose a final dtb from DT fragments and pass it to the kernel, or
>> alternatively the bootloader would pass the base dtb image and a bunch
>> of DT overlays to the kernel, and the kernel would deal with the DT
>> overlays.
> 
> Speaking as somebody who's written the "bootloader" code that's
> used for what I guess are the majority of versatile kernel boots,
> i.e. the one in QEMU, I think that requiring the bootloader to do this
> would be a significant worsening from the current state.
> 
> Right now the bootloader doesn't need to do much at all with device
> trees, except pass the kernel the DT that the user gave us, which
> is just the kernel's own data structures in a separate file for
> convenience. You need to do some very minor tweaks to the /chosen
> node, but these can be handled the same way for any board and aren't
> hardware specific. There's no need to worry about dt fragments
> either for the bootloader or for the user. Imposing a new requirement
> for the bootloader to have to probe hardware which it otherwise
> has no need to even care about, and then edit and update the DT
> in a board-specific manner, or have board-specific DT fragments,
> seems like a totally unnecessary imposition on both bootloader
> authors and end-users, and of course it would break booting newer
> kernels on the great mass of already existing boot loaders and
> QEMU installs.

I'm looking for a good generic solution for going forward that can be
used on new boards, for both non-probeable and probeable displays.

When we have that solution, we can see if and how the solution could be
used for current boards. I'm sure that for some boards we need to
support whatever legacy methods are out there already.

> The kernel is in a position to probe the display hardware and determine
> what is there, and do the right thing, and that's exactly what it
> does today. The kernel should continue to do this.
> The advantage of DT is that it allows moving information about
> non-probeable hardware that was previously hardwired in the kernel
> C sources into a separate data structure, but the versatile displays
> are not non-probeable. I can see no benefit at all from hardwiring into
> the dt something which the kernel has previously been successfully
> dynamically getting right without any bootloader intervention -- it just
> makes the kernel less flexible and less user-friendly.

My opinion is that the bootloader should be responsible for telling the
kernel what hardware there is on the board. For busses like PCI we have
proper probing mechanism with global unique identifiers for the devices,
and nothing is needed from the bootloader.

In the Versatile case the panels are kind of probeable, but not in the
same sense as PCI: all that can be probed on Versatile is a board
specific ID, which in itself doesn't tell what kind of panel there is.
In addition to the ID we need board specific tables listing the details
of the panels.

So, true, there's probing going on, but it's all board specific,
requiring a board specific driver to support it in the kernel. And I
think that makes the bootloader much better place for supporting it.
But, again, for legacy reasons that may not be possible.

Now, _if_ the Versatile panels were hotpluggable, and it would be a
normal use case to switch the panels at runtime and having the kernel
automatically switch to the correct video mode, we would obviously need
a kernel driver for it. But afaik that's not the case.

I think one of the core questions here is: do we want to start adding
board specific drivers to the kernel, instead of dealing with it in the
bootloader when possible? My understanding is that we've been trying to
reduce board specific code from the kernel.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160223/3b325e20/attachment.sig>
