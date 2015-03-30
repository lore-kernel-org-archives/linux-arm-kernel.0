From: mmarek@suse.cz (Michal Marek)
Date: Mon, 30 Mar 2015 16:13:05 +0200
Subject: [RFC PATCH 2/2] Kbuild: avoid partial linking of
 drivers/built-in.o
In-Reply-To: <CAKv+Gu8-4XR5D-0_JnVfS2LNkH_Uvcc5txe4wJhwZogc5hZ-1w@mail.gmail.com>
References: <1427716167-25078-1-git-send-email-ard.biesheuvel@linaro.org>	<1427716167-25078-3-git-send-email-ard.biesheuvel@linaro.org>	<551943CB.3010303@suse.cz>	<20150330132617.GI24899@n2100.arm.linux.org.uk>
 <CAKv+Gu8-4XR5D-0_JnVfS2LNkH_Uvcc5txe4wJhwZogc5hZ-1w@mail.gmail.com>
Message-ID: <551959F1.4030704@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-30 15:31, Ard Biesheuvel wrote:
> On 30 March 2015 at 15:26, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Mar 30, 2015 at 02:38:35PM +0200, Michal Marek wrote:
>>> Is this a limitation of a particular ARM ABI or a limitation of a state
>>> of the art ARM linker or something else?
>>
>> It's a limitation of the ARM ISA.
>>
>> Normal PC-relative branches, which are emitted by the C compiler, can
>> branch +/- 32MB for ARM, or +/- 16MB of Thumb.  Beyond that, the address
>> offset is not representable in the instruction.

Thank you both for the explanation!


>> The question is: how far do we go with allyesconfig... do we want it
>> to work, or is reaching the final link sufficient?

It certainly is more useful as a test tool if the baseline is a
successful compile and link. Because you can have genuine link errors
due to missing symbols.


>> If we do tweak
>> stuff to allow the link to work, are we going to try running it?

Good question. I myself always treated all{yes,mod}config as a build
test only and never dared to run it. Allyesconfig produces a giant
kernel image and allmodconfig builds binfmt_script as a module. And if
people used all*config for boot tests, they would probably be sending
patches to tweak the Kconfigs for that purpose. And this is not the case
as far as I can tell.


> That is an excellent question, hence the RFC in the subject line.
> 
> Note that the other patch, the one against kallsyms, addresses the
> issue where the distance between the beginning of .text and the end of
> .init.text  exceeds this limit, which is not as unlikely as the issue
> that this patch addresses, where just drivers/built-in.o in isolation
> already exceeds this limit.
> 
> So I am quite happy to drop this, especially as we can add
> -ffunction-sections as well.

What you could do is to add a Kconfig option to arch/arm/Kconfig adding
-ffunction-sections to the compiler flags. Then allyesconfig would
select it and work around the problem in a somewhat elegant way.

Michal
