From: borntraeger@de.ibm.com (Christian Borntraeger)
Date: Tue, 19 Jul 2016 22:44:58 +0200
Subject: [PATCH v3 02/11] mm: Hardened usercopy
In-Reply-To: <CAGXu5j+HqLY1gZycV9S9_Vf8uuQj4Z3qsV8WBxLORuseiJaw5Q@mail.gmail.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <1468619065-3222-3-git-send-email-keescook@chromium.org>
 <578DF109.5030704@de.ibm.com>
 <CAGXu5jKRDuELqGY1F-D4+MD+dMXSbiPGzf1hXb7Kp8ACBjpw9g@mail.gmail.com>
 <578E8A22.5080807@de.ibm.com>
 <CAGXu5j+HqLY1gZycV9S9_Vf8uuQj4Z3qsV8WBxLORuseiJaw5Q@mail.gmail.com>
Message-ID: <578E914A.7070900@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2016 10:34 PM, Kees Cook wrote:
[...]
>>
>> So what about for the CONFIG text:
>>
>>        An architecture should select this if the kernel mapping has a secondary
>>        linear mapping of the kernel text - in other words more than one virtual
>>        kernel address that points to the kernel image. This is used to verify
>>        that kernel text exposures are not visible under CONFIG_HARDENED_USERCOPY.
> 
> Sounds good, I've adjusted it for now.
> 
>>> I wonder if I can avoid the CONFIG entirely if I just did a
>>> __va(__pa(_stext)) != _stext test... would that break anyone?
>>
>> Can this be resolved on all platforms at compile time?
> 
> Well, I think it still needs a runtime check (compile-time may not be
> able to tell about kaslr, or who knows what else). I would really like
> to avoid the CONFIG if possible, though. Would this do the right thing
> on s390? This appears to work where I'm able to test it (32/64 x86,
> 32/64 arm):
> 
>         unsigned long textlow = (unsigned long)_stext;
>         unsigned long texthigh = (unsigned long)_etext;
>         unsigned long textlow_linear = (unsigned long)__va(__pa(textlow);
>         unsigned long texthigh_linear = (unsigned long)__va(__pa(texthigh);
> 
as we have

#define PAGE_OFFSET             0x0UL
#define __pa(x)                 (unsigned long)(x)
#define __va(x)                 (void *)(unsigned long)(x)

both should be identical on s390 as of today, so it should work fine and only
do the check once

>         if (overlaps(ptr, n, textlow, texthigh))
>                 return "<kernel text>";
> 
>         /* Check against possible secondary linear mapping as well. */
>         if (textlow != textlow_linear &&
>             overlaps(ptr, n, textlow_linear, texthigh_linear))
>                 return "<linear kernel text>";
> 
>         return NULL;
> 
> 
> -Kees
> 


PS: Not sure how useful and flexible this offers is but you can get some temporary
free access to an s390 on https://developer.ibm.com/linuxone/
