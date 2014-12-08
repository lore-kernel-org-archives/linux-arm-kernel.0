From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 08 Dec 2014 12:15:52 +0100
Subject: [alsa-devel] Question on arm64 unaligned faults during playback
In-Reply-To: <s5hppbumnis.wl-tiwai@suse.de>
References: <CAM4voa=kiLsiLEzUbo3D+f1go5px78fXBSjSi7kGK4QCdnwPyQ@mail.gmail.com>	<54856621.8090107@ladisch.de>
 <s5hppbumnis.wl-tiwai@suse.de>
Message-ID: <54858868.70708@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added ARM64 folks to Cc.

On 12/08/2014 11:41 AM, Takashi Iwai wrote:
> At Mon, 08 Dec 2014 09:49:37 +0100,
> Clemens Ladisch wrote:
>>
>> Abhilash Kesavan wrote:
>>> I am working on a 64-bit ARM SoC (Samsung's Exynos7) and have observed
>>> unaligned faults while testing certain sound streams with aplay.
>>>
>>> [   24.535661] snd_pcm_lib_write_transfer:sound/core/pcm_lib.c hwbuf is ffffff8000085624, runtime->dma_area is ffffff8000080000, hwoff is 5513, frames_to_bytes is 22052, frames is 5513
>>> [   24.551244] Unhandled fault: alignment fault (0x96000061) at 0xffffff8000085624
>>> [   24.579944] PC is at __copy_from_user+0x14/0x60
>>> [   24.584450] LR is at snd_pcm_lib_write_transfer+0xe4/0x104
>>> [   24.922054] Call trace:
>>> [   24.924488] [<ffffffc0002d4784>] __copy_from_user+0x14/0x60
>>> [   24.930040] [<ffffffc0004b7574>] snd_pcm_lib_write1+0x1fc/0x384
>>>
>>> We are using the internal sram available for sound, for DMA buffer
>>> allocation, using the generic SRAM driver. From the above log, the
>>> buffer address offset is not 8-byte aligned and as we are using the
>>> SRAM driver which maps the memory as device memory we are getting an
>>> unaligned fault. Is it incorrect to use the generic sram driver for
>>> arm64 or am I missing something ?
>>
>> When you give the ALSA framework a memory buffer, it is assumed that it
>> is general-purpose memory, i.e., can be accessed with any alignment.
>>
>> If your memory does not allow such accesses, you have to do all the
>> accesses in your driver, i.e., do everything in the .copy/.silence
>> callbacks.  (You also have to add constraints so that periods and buffer
>> are correctly aligned.)
>
> You can set runtime->min_align in the own hw_params callback so that
> the PCM core handle it well, at least, for non-mmap mode.
>
> But this feature has been rarely used (currently no driver sets it
> explicitly), so there might be still some bugs there, too :)

As far as I can see min_align only aligns the hardware pointer, but not the 
application pointer. The later causes the issue here.

E.g. if a application writes a unaligned amount of bytes the next write will 
start at an unaligned buffer address.

How safe is it in general to use IO mapped memory as general purpose memory 
on ARM64? Are there maybe even more constraints than just that access has to 
be aligned? Maybe the driver should rather use copy_from_user_toio() instead 
of copy_from_user() to make sure that things work correctly.

- Lars
