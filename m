From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 8 Mar 2018 07:02:49 +0000
Subject: arm crypto .S_shipped files sometimes get rebuilt randomly
In-Reply-To: <CAK7LNARDPOaLyvcijXe5VX3hJhxzS-R5hdbk310bRUuZwQFMmw@mail.gmail.com>
References: <1520450729.13685.19.camel@nxp.com>
 <CAK7LNARDPOaLyvcijXe5VX3hJhxzS-R5hdbk310bRUuZwQFMmw@mail.gmail.com>
Message-ID: <CAKv+Gu9bWQyUwxgS1Vvp8U__Wg-4Tby2vKvOozsp9RA41Wo6SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 March 2018 at 05:00, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> 2018-03-08 4:25 GMT+09:00 Leonard Crestez <leonard.crestez@nxp.com>:
>> Hello,
>>
>> I am using a toolchain with a broken/old version of perl which doesn't
>> include integer.pm and I noticed it triggers occasional build failures
>> on arch/arm64/crypto/sha512-core.S_shipped. Workarounds are easy, but
>> if the purpose of the .S_shipped is to avoid the need to have all
>> dependencies on the build machine then something went wrong?
>>
>> This was introduced by commit 7918ecef073f ("crypto: arm64/sha2 -
>> integrate OpenSSL implementations of SHA256/SHA512"). The makefile
>> rules are not terribly complicated:
>>
>> quiet_cmd_perlasm = PERLASM $@
>>       cmd_perlasm = $(PERL) $(<) void $(@)
>>
>> $(src)/sha512-core.S_shipped: $(src)/sha512-armv8.pl
>>         $(call cmd,perlasm)
>>
>> If a decision to rerun the rule is made based on their relative
>> timestamps but both .S_shipped and sha512-armv8.pl are included in git
>> then won't the result be essentially random, depending on file checkout
>> order?
>>

I agree with your analysis, although  I never see these spurious
rebuilds of these files.

>> I see random success/failure by just running something like the
>> following multiple times:
>>         rm -rf arch/arm64/crypto
>>         git co -f arch/arm64/crypto
>>         make -- arch/arm64/crypto/
>>
>> A reasonable fix might be to simply drop .S_shipped and require a
>> functional recent version of perl. Then if it fails it will fail
>> reliably.
>>
>
> Indeed, this Makefile is weird.
> We have two choices.
>
>
> [1] If we intend to generate
> sha{256,512}-core.S from the perl script during the build,
> this should be:
>
> $(obj)/sha512-core.S: $(src)/sha512-armv8.pl
>         $(call cmd,perlasm)
>
> $(obj)/sha512-core.S: $(src)/sha512-armv8.pl
>         $(call cmd,perlasm)
>
>
> [2] If we want to check-in _shipped files
> and avoid running perl during the build,
> we can surround unnecessary rules with if-conditional, like
>
>
> if REGENERATE_ARM64_SHA
> $(src)/sha256-core.S_shipped: $(src)/sha512-armv8.pl
>         $(call cmd,perlasm)
>
> $(src)/sha512-core.S_shipped: $(src)/sha512-armv8.pl
>         $(call cmd,perlasm)
> endif
>
>
> Set REGENERATE_ARM64_SHA=1 from the command line
> only when you need to update the _shipped files.
>
> This is what commit 7373f4f83c71d50f0aece6d94309ab7fde42180f did.
>
>
>
>
> Recently, Kconfig switched to [1].
> So, flex and bison are required to build the kernel.
>

I would prefer option [1], but only if it is already documented
somewhere that Perl is a build time dependency.
