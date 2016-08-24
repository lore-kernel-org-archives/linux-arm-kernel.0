From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 24 Aug 2016 15:58:51 +0900
Subject: Why do we need reset_control_get_optional() ?
In-Reply-To: <CAK7LNAQdZu+C1XF1Y_KwvCQpoa1AUY0cyRcg=1PcHQaQxN79ng@mail.gmail.com>
References: <CAK7LNAQnitMMp5wMXXvVeS-UFF=Fo9m=M1hL=5f4=RF8JYCnGg@mail.gmail.com>
 <CAK7LNAQ0nCQymq+M+FTUXoK7yBj_5CJp9nqDjO3u5wcnckXtmw@mail.gmail.com>
 <1469703649.12835.34.camel@pengutronix.de> <1859714.7lR6dsl2IG@wuerfel>
 <1470674376.2497.49.camel@pengutronix.de>
 <CAK7LNAQdZu+C1XF1Y_KwvCQpoa1AUY0cyRcg=1PcHQaQxN79ng@mail.gmail.com>
Message-ID: <CAK7LNAR1D=c1rreocGKM-10ZJCTrnDiScZss5C4wFOAbqvQK-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

2016-08-16 23:36 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Philipp, Arnd.
>
>
>
> 2016-08-09 1:39 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
>> Am Freitag, den 05.08.2016, 17:50 +0200 schrieb Arnd Bergmann:
>>> On Thursday, July 28, 2016 1:00:49 PM CEST Philipp Zabel wrote:
>>> > Am Donnerstag, den 28.07.2016, 19:52 +0900 schrieb Masahiro Yamada:
>>>
>>> > > > In my experimental patch, I make the _optional functions
>>> > > > return NULL if no "resets" property is provided but return
>>> > > > an error if there are reset lines but the subsystem is
>>> > > > disabled, i.e. an optional reset must be used if it's in the
>>> > > > DT, but can be ignored otherwise.
>>> > >
>>> > > I do not like this idea.
>>> > >
>>> > > reset_control_get() (or variants) should not return NULL, it is ambiguous.
>>> > > It should return ERR_PTR(-ENOENT) if no "resets" property.
>>> > >
>>> > > I only want two types for functions that return a pointer.
>>> > >
>>> > > [1] return a valid pointer on success, or return NULL on failure
>>> > >     (for example, kmalloc())
>>> > > [2] return a valid pointer on success, or return error pointer on failure
>>> > >    (many of _register() functions)
>>> > >
>>> > > Mixing [1] and [2] will be a mess.
>>>
>>> Ah, right. I was thinking only of the case where the reset subsystem
>>> is completely disabled here, so returning NULL could be considered
>>> a valid return code that can in turn be passed into the other
>>> functions.
>>>
>>> However, I agree that returning NULL as a valid result from
>>> ..._get_optional() would be bad style, so let's drop my idea
>>> there.
>>>
>>> > I too would prefer to keep that as-is. The reset_control_get_optional
>>> > stub could return -ENOENT if there is no resets device tree property.
>>>
>>> Now I'm also confused about what we really need
>>> reset_control_get_optional() for, and which error codes the callers
>>> are supposed to check.
>>>
>>> This is the matrix I think you mean for _get_optional:
>>>
>> [...]
>>> CONFIG_RESET_CONTROLLER=n, dt entry present: -EOPNOTSUPP
>>> CONFIG_RESET_CONTROLLER=n, dt entry missing: -ENOENT
>>
>> ^^ I didn't consider this distiction.
>>
>>> Is this what you had in mind? If so, what is the value of the
>>> added runtime warning for reset_control_get? Any caller of that
>>> function would already check for errors, the only difference
>>> I see is that callers of _optional can ignore -ENOENT.
>>
>> My initial motivation was to make it as hard as possible to misconfigure
>> the kernel, which is why I initially didn't want stubs for the
>> non-optional variant. Of course that would cause build failures and/or
>> reduced compile test coverage, so we added the stubs and the warning to
>> make it obvious when a misconfigured kernel is running: on a kernel with
>> RESET_CONTROLLER=n drivers that use reset_control_get are expected to
>> build, but they are not expected to work. I suppose the same is the case
>> for _optional, if the dt entry is present, so maybe we should drop
>> reset_control_get_optional and add always a warning in case of
>> -EOPNOTSUPP.
>> I don't want all drivers to have to differentiate between -EOPNOTSUPP
>> and -ENOENT error codes, only current reset_control_get_optional users
>> have to do that.
>
>
> I've posted a patch to drop reset_control_get_optional;
> https://patchwork.kernel.org/patch/9284063/
>
> Could you check if it works?
>
> If we go this way, my patch
> 289363fd99a17d6249ee1373541f1da43cbb22c5
> in your reset/next branch is completely useless.
>
> As the commits in the reset-subsystem do not appear
> even in linux-next until they are pulled into the ASOC tree,
> how about dropping 289363fd and turning around?
>


If you want to take time for this topic,
how about dropping 289363fd99a17d6249ee1373541f1da43cbb22c5
("reset: add WARN_ON(1) to non-optional reset_control_get variants")
for now?


I noticed some reset consumers already started dropping _optional,
while their reset lines should be really optional.

See
commit d0e08b0077f49e209bc90305ddf1ca434ac6cc0e
commit 62d9694a003dba585026df36c181e3ca930aeafc

Even generic drivers such as ehci-platform.c / ohci-platform.c
opted out of _optional.


If commit 289363fd99a17d6249ee1373541f1da43cbb22c5 is merged,
users of the generic drivers but without reset-controller
will start to complain about the WARN_ON(1)  sooner or later.


-- 
Best Regards
Masahiro Yamada
