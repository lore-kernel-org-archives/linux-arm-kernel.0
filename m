From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 18 Feb 2016 14:38:25 +0000
Subject: [PATCH v2 1/2] efi: esrt: use memremap not ioremap to access
 ESRT table in memory
In-Reply-To: <CAKv+Gu8RP21vw1Ht7UtkHsen2GMUNx8DikH-hLaezV+uZvWO-g@mail.gmail.com>
References: <1455535953-5056-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455535953-5056-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160218104407.GC2651@codeblueprint.co.uk>
 <CAKv+Gu_AW7PKJJOd2mbEu3LKJe+gNaPHnH=sgO=YXM_KWFyKxw@mail.gmail.com>
 <20160218132824.GE2651@codeblueprint.co.uk>
 <CAKv+Gu-s1pzYBzuDG-Z7s3gyo8dPOfeidZQ+rim-uAWZCBcKQQ@mail.gmail.com>
 <20160218134324.GG2651@codeblueprint.co.uk>
 <CAKv+Gu875r9RkDC723kNsG4XC0eSE9RPPmSFZrD0sx0QxS+V4g@mail.gmail.com>
 <20160218141544.GH2651@codeblueprint.co.uk>
 <CAKv+Gu8RP21vw1Ht7UtkHsen2GMUNx8DikH-hLaezV+uZvWO-g@mail.gmail.com>
Message-ID: <20160218143825.GI2651@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Feb, at 03:21:25PM, Ard Biesheuvel wrote:
> 
> We treat all Boot Services regions like Loader Code/Data or free
> regions: it is all recorded in memblock as usable memory, and only the
> regions that are explicitly reserved are protected from further
> general use.
> 
> I am currently looking into the memory attribute table, and the use
> case is very similar. It would be very useful from our pov to simply
> memblock_reserve() the region right after having called
> efi_config_parse_tables(), and actually consume its data when we get
> around to it later. The ESRT handling is already split down the middle
> in the same way.

Agreed, this would also be useful in general for kexec. I've got a
couple of patches in flight that try to handle the BGRT case in a
different way,

  https://lkml.kernel.org/r/1455723910-16710-2-git-send-email-matt at codeblueprint.co.uk
  https://lkml.kernel.org/r/1455723910-16710-3-git-send-email-matt at codeblueprint.co.uk

Let me instead take a look at how we might be able to preserve only
those Boot Services regions we care out.
