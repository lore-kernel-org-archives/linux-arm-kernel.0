From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Wed, 10 Dec 2014 09:40:50 +0530
Subject: [alsa-devel] Question on arm64 unaligned faults during playback
In-Reply-To: <20141209114343.GA31129@e104818-lin.cambridge.arm.com>
References: <CAM4voa=kiLsiLEzUbo3D+f1go5px78fXBSjSi7kGK4QCdnwPyQ@mail.gmail.com>
 <54856621.8090107@ladisch.de> <s5hppbumnis.wl-tiwai@suse.de>
 <54858868.70708@metafoo.de>
 <20141208122549.GF16185@e104818-lin.cambridge.arm.com>
 <CAM4voam0h4e1Z8q3eqNpgMhhfw-zJpfh7fi4iznX_Y0bj98nKA@mail.gmail.com>
 <20141209114343.GA31129@e104818-lin.cambridge.arm.com>
Message-ID: <CAM4voakZbZ=4dZBuxyFs8eaoWvSBQzQR36+-E-=F9bDDb9wjfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, Dec 9, 2014 at 5:13 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Dec 09, 2014 at 02:56:59AM +0000, Abhilash Kesavan wrote:
>> On Mon, Dec 8, 2014 at 5:55 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Mon, Dec 08, 2014 at 11:15:52AM +0000, Lars-Peter Clausen wrote:
>> >> On 12/08/2014 11:41 AM, Takashi Iwai wrote:
>> >> > At Mon, 08 Dec 2014 09:49:37 +0100,
>> >> > Clemens Ladisch wrote:
>> >> >>
>> >> >> Abhilash Kesavan wrote:
>> >> >>> I am working on a 64-bit ARM SoC (Samsung's Exynos7) and have observed
>> >> >>> unaligned faults while testing certain sound streams with aplay.
>> >> >>>
>> >> >>> [   24.535661] snd_pcm_lib_write_transfer:sound/core/pcm_lib.c hwbuf is ffffff8000085624, runtime->dma_area is ffffff8000080000, hwoff is 5513, frames_to_bytes is 22052, frames is 5513
>> >> >>> [   24.551244] Unhandled fault: alignment fault (0x96000061) at 0xffffff8000085624
>> >> >>> [   24.579944] PC is at __copy_from_user+0x14/0x60
>> >> >>> [   24.584450] LR is at snd_pcm_lib_write_transfer+0xe4/0x104
>> >> >>> [   24.922054] Call trace:
>> >> >>> [   24.924488] [<ffffffc0002d4784>] __copy_from_user+0x14/0x60
>> >> >>> [   24.930040] [<ffffffc0004b7574>] snd_pcm_lib_write1+0x1fc/0x384
>> >
>> > I can see copy_from_user() here, I assume the source is a user space
>> > buffer and the destination is the ioremap'ed SRAM (which causes the
>> > unaligned fault). Such function is not supposed copy into device memory
>> > (its prototype does not specify __iomem for the destination pointer).
>> >
>> > If you really want Device memory for the SRAM, I think we need some
>> > other API. memcpy_toio() could copy into such buffer but the source must
>> > be kernel. Maybe something like copy_from_user_toio()?
>>
>> Thanks for the response.
>>
>> Changing copy_from_user() to copy_from_user_toio() in
>> snd_pcm_lib_write_transfer() (sound/core/pcm_lib.c) works. I am not
>> sure about other effects of making such a change in a core sound file,
>> can someone comment ?
>
> The default implementation uses copy_from_user() to an intermediate
> buffer and another memcpy_toio() to the SRAM destination. So, it will be
> slower.
>
> In general it may be better to copy this function to some more generic
> place and let the arch code override it with a more optimal
> implementation.
>
>> > Otherwise, if you can remap the buffer as Normal (non-cacheable) memory,
>> > you could use something like vmap() with pgprot_writecombine for the
>> > mapping. Even though ioremap_wc() returns (currently) Normal
>> > non-cacheable memory, such pointer (__iomem) should only be used with
>> > specific IO accessors (though I can see this assumption broken in a few
>> > places in the kernel).
>>
>> Currently, if I continue to use the SRAM allocation driver, two
>> options are working:
>> 1) ioremap to ioremap_wc in drivers/misc/sram.c.
>
> I think the SRAM driver does the correct devm_ioremap_resource() call
> but the implementation in lib/devres.c assumes that if
> IORESOURCE_CACHEABLE it should use devm_ioremap(). AFAIK, ioremap()
> always returns Device memory (even on x86, the default ioremap behaviour
> is nocache).
>
>> 2) copy_from_user to copy_from_user_toio in sound/core/pcm_lib.c
>>
>> Which would be the preferred option ?
>
> I would prefer the sram changed. It provides an allocation pool from
> SRAM which could as well be mapped as write-combine. If no-one complains
> about changing the SRAM mapping to WC, you could introduce a
> devm_ioremap_wc() in lib/devres.c and call that directly from
> sram_probe(). But I can't tell for sure what the memory type
> expectations for SRAM are.

Thanks for the response. I will post patches to do this.
Also, adding guys who have been working on the generic sram driver and
internal sram support for sound in case they have any comments
regarding the change to ioremap_wc.

Regards,
Abhilash
