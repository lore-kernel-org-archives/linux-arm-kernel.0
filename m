From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 19 Aug 2017 22:34:26 +0200
Subject: [GIT PULL 6/6] Broadcom drivers changes for 4.14
In-Reply-To: <124419b2-4f45-d282-2aea-c8e0c3a819c5@gmail.com>
References: <20170817183748.1450-1-f.fainelli@gmail.com>
 <20170817183748.1450-7-f.fainelli@gmail.com>
 <CAK8P3a1id0Wd7XdH+9MsgaK-UCNmYE5ks1p4bzont-T03v5tEA@mail.gmail.com>
 <124419b2-4f45-d282-2aea-c8e0c3a819c5@gmail.com>
Message-ID: <CAK8P3a0RDuMAdACCepTj_zr4NkocM5vSVGEayjGPbyTuQ7TwBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 19, 2017 at 12:35 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 08/18/2017 02:58 PM, Arnd Bergmann wrote:
>> On Thu, Aug 17, 2017 at 8:37 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>>>
>>>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.14/drivers
>>>
>>> for you to fetch changes up to 7f95522be533c27a918fe388ae5d733344660ef2:
>>>
>>>   soc bcm: brcmstb: Add support for S2/S3/S5 suspend states (MIPS) (2017-07-28 16:57:03 -0700)
>>>
>>> ----------------------------------------------------------------
>>> This pull request contains Broadcom ARM/ARM64 SoC drivers changes for 4.14,
>>> please pull the following:
>>>
>>> - Markus adds support for the Broadcom STB DDR PHY frontend which supports
>>>   dynamic firmware loading and offers the ability to respond with DRAM refresh
>>>   rates. He also adds a proper documentation binding document for that peripheral
>>>
>>
>> I had not seen this driver before, but now I looked at it and have two small
>> comments:
>>
>> - I'd rather see this added to drivers/memory than drivers/soc. The distinction
>>   is not always clear, but I think that's where most of the DDR memory interface
>>   drivers are at the moment.
>
> This driver does not control the SoC's memory interface though it does
> talk to the frontend processor built into the DDR controller to first
> load its firmware and then query it to get the DDR refresh rates. If you
> feel like drivers/memory/broadcom/ is more appropriate I suppose we
> could relocate the driver there.

Yes, I still think it makes sense to put it there, although it's not the only
possible choice. drivers/memory is a very broad category that groups
all kinds of things that are related to memory interfaces.

>> - In a function called __write_firmware, I stumbled over this small
>>   hunk and similar functions elsewhere in the driver:
>>
>> +       /* Now copy it. */
>> +       if (is_big_endian) {
>> +               for (i = 0; i < size; i++)
>> +                       writel_relaxed(be32_to_cpu(fw[i]), mem + i);
>> +       } else {
>> +               for (i = 0; i < size; i++)
>> +                       writel_relaxed(fw[i], mem + i);
>> +       }
>>
>> This looks wrong to me, as the behavior is different between
>> little-endian and big-endian kernels: the former will byteswap
>> big-endian fw images but not little-endian images, while the
>> latter will byte-swap both.
>>
>> What is the expected behavior here?
>
> So the is_big_endian flag actually refers to the endianess of the DPFE
> CPU/firmware image here, so if I read this code correctly, we have the
> following happening
>
> LE kernel + BE DPFE: swapping from BE to LE during file read but not I/O
> write (KO because resulting DPFE image is LE)
> LE kernel + LE DPFE: no-swapping (OK)
>
> BE kernel + BE DPFE: swapping to LE during I/O write not file read (KO,
> because resulting DPFE image is LE)
> BE kernel + LE DPFE: swapping to LE during I/O write not file read (OK)
>
> Markus, does that sound like what is happening?

I suspect it would be better to never swap while copying the image from
memory to I/O and always use memcpy_toio there, which performs
a byte stream copy. The information you then need really is not what
the endianess of the DPFE CPU is, but rather if it was stored as
byte-reversed in the file.

       Arnd
