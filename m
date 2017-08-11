From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Aug 2017 11:34:36 +0200
Subject: New assembler warnings with binutils 2.29
In-Reply-To: <CAKv+Gu8EQq+azTjMNDpE=TzEd_6b-VdQqUYbCc1=qGuYTU4Srg@mail.gmail.com>
References: <d101c48b-c47b-be60-4b40-de4f845e4965@redhat.com>
 <20170811092213.mdmzqtm2lp6ltlxt@armageddon.cambridge.arm.com>
 <CAKv+Gu8EQq+azTjMNDpE=TzEd_6b-VdQqUYbCc1=qGuYTU4Srg@mail.gmail.com>
Message-ID: <CAK8P3a1Bza56jpNcpbSDLXsHL08yiXEnKqNmevNpw_z9iym_qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 11:26 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 11 August 2017 at 10:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> On Thu, Aug 10, 2017 at 01:13:22PM -0700, Laura Abbott wrote:
>>> Fedora rawhide recently upgraded to binutils 2.29 and this seems
>>> to produce new warnings:
>>>
>>> ./arch/arm64/include/asm/assembler.h: Assembler messages:
>>> ./arch/arm64/include/asm/assembler.h:125: Warning: ignoring attempt to redefine built-in register 'lr'
>>>
>>> This is
>>>
>>> /*
>>>  * Register aliases.
>>>  */
>>> lr      .req    x30             // link register
>>
>> Strange, does gas now think 'lr' is a general purpose register (aliased
>> to x30)? It never was and IIRC the toolchain people many years ago
>> refused to add it, hence the alias above in the kernel. I wonder if they
>> added 'fp' as well...
>>
>> We could remove the alias and replace all 'lr' instances with 'x30'
>> throughout the kernel (no too many) or we add some #ifdef around the
>> above based on the binutils version.
>>
>
> This is annoying. Replacing x30 with lr achieves the opposite of the
> intent of the binutils change. And using #ifdefs is inaccurate,
> because you can't really test the binutils version only the GCC
> version, and those are not tightly coupled.
>
> Can you .unreq it?

adding the author of the change to cc

https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=62e20ed45e3da5f3ba695e4ee109317668180fe6

There probably was some reasoning behind the change and an
intended method for using it.

    Arnd
