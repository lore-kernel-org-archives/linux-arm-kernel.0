From: luto@amacapital.net (Andy Lutomirski)
Date: Sun, 13 Mar 2016 21:44:59 -0700
Subject: [PATCH] kbuild: drop FORCE from PHONY targets
In-Reply-To: <CAK7LNAQOJjcn7Q+s_pKqzUuojMBtOsRNKsmVwDFXvTeU-zvSeQ@mail.gmail.com>
References: <1457828035-30584-1-git-send-email-yamada.masahiro@socionext.com>
 <CALCETrVqzidL7SXsCVm8wWrcQMR9dFOLGnDtC-eEYMO4a+yszA@mail.gmail.com>
 <CAK7LNARELkQbhAfBdh9Tx7gVGkpN9gTJzoqJwOF-0CH4zm+wcw@mail.gmail.com>
 <CALCETrVgSUy4ofeBmkZ7TurKvmQVX8C1aj__SLOL6SboQ3S-WA@mail.gmail.com>
 <CAK7LNAQOJjcn7Q+s_pKqzUuojMBtOsRNKsmVwDFXvTeU-zvSeQ@mail.gmail.com>
Message-ID: <CALCETrU+6sj=reBgPBy7Mq6KYY7BKkVLGwm4XrVzOzb8aU+meg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 13, 2016 at 9:36 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2016-03-14 13:28 GMT+09:00 Andy Lutomirski <luto@amacapital.net>:
>> On Sun, Mar 13, 2016 at 9:08 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>>
>>> Hi Andy
>>>
>>> 2016-03-14 9:39 GMT+09:00 Andy Lutomirski <luto@amacapital.net>:
>>> > On Mar 12, 2016 4:14 PM, "Masahiro Yamada"
>>> > <yamada.masahiro@socionext.com> wrote:
>>> >>
>>> >> These targets are marked as PHONY.  No need to add FORCE to their
>>> >> dependency.
>>> >
>>> > If this is, in fact, correct, can you update
>>> > Documentation/kbuild/makefiles.txt as well?
>>>
>>> Which line do you want me to update?
>>>
>>
>> All the references to FORCE should probably mention .PHONY as an alternative.
>
> I do not get your point.
>
> All the examples in the makefile.txt correctly reference to FORCE.
> They are not PHONY targets.
> No need to update.

But they could be.  For example:

                $(obj)/image: vmlinux FORCE
                        $(call if_changed,objcopy)

could be:

                 .PHONY: $(obj)/image
                $(obj)/image: vmlinux
                        $(call if_changed,objcopy)

I would at least change:

Note: It is a typical mistake to forget the FORCE prerequisite.

to:

Note: if-changed is only useful if make executes it, which won't
happen if it determines that the inputs have not changed since the
output was built.  This can be avoided by specifying FORCE as a
prerequisite or by making declaring the output as .PHONY.

--Andy

>
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Andy Lutomirski
AMA Capital Management, LLC
