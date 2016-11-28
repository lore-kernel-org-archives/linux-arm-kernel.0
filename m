From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 28 Nov 2016 09:50:33 +0000
Subject: [PATCH v4] crypto: arm64/sha2: integrate OpenSSL implementations
 of SHA256/SHA512
In-Reply-To: <CAKv+Gu9SG5s=zddQaw+444191JGqmXfCh+AKyv3nZNqggmh=Kw@mail.gmail.com>
References: <1479642121-17912-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9SG5s=zddQaw+444191JGqmXfCh+AKyv3nZNqggmh=Kw@mail.gmail.com>
Message-ID: <CAKv+Gu9RVFQ4SNzbHbNCFSXy01b+_dCeRc4bXgZagovGy9BYtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2016 at 11:43, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 20 November 2016 at 11:42, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> This integrates both the accelerated scalar and the NEON implementations
>> of SHA-224/256 as well as SHA-384/512 from the OpenSSL project.
>>
>> Relative performance compared to the respective generic C versions:
>>
>>                  |  SHA256-scalar  | SHA256-NEON* |  SHA512  |
>>      ------------+-----------------+--------------+----------+
>>      Cortex-A53  |      1.63x      |     1.63x    |   2.34x  |
>>      Cortex-A57  |      1.43x      |     1.59x    |   1.95x  |
>>      Cortex-A73  |      1.26x      |     1.56x    |     ?    |
>>
>> The core crypto code was authored by Andy Polyakov of the OpenSSL
>> project, in collaboration with whom the upstream code was adapted so
>> that this module can be built from the same version of sha512-armv8.pl.
>>
>> The version in this patch was taken from OpenSSL commit 32bbb62ea634
>> ("sha/asm/sha512-armv8.pl: fix big-endian support in __KERNEL__ case.")
>>
>> * The core SHA algorithm is fundamentally sequential, but there is a
>>   secondary transformation involved, called the schedule update, which
>>   can be performed independently. The NEON version of SHA-224/SHA-256
>>   only implements this part of the algorithm using NEON instructions,
>>   the sequential part is always done using scalar instructions.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>
> Missing changelog:
>
> v4: fixed the big-endian build; this required an upstream change (even
>     though upstream was not actually broken, since it explicitly defines
>     __ARMEB__ on AArch64 big-endian builds), so this patch is now based
>     on a more recent upstream OpenSSL commit (the __ILP32__ #ifdefs are
>     still present but never active)
>
> v3: at Will's request, the generated assembly files are now included
>     as .S_shipped files, for which generic build rules are defined
>     already.
>
> Note that sizeable patches like this one have caused issues in the past with
> patchwork, so for Herbert's convenience, the patch can be pulled from
> http://git.kernel.org/cgit/linux/kernel/git/ardb/linux.git, branch
> arm64-sha256 (based on today's cryptodev)

Herbert,

Assuming that everyone is happy now (Will?), could we get this one
queued for v4.10? The CRC stuff I sent over the past week can wait for
v4.11 (and I should probably do a v2 roundup with everything
combined), but this patch is good to go IMO

Thanks,
Ard.
