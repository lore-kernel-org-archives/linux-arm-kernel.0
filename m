From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 11 Nov 2016 12:19:05 +0900
Subject: [PATCH 0/2] mmc: allow mmc_alloc_host() and tmio_mmc_host_alloc()
In-Reply-To: <20161110133559.GA10191@kroah.com>
References: <1478784263-18777-1-git-send-email-yamada.masahiro@socionext.com>
 <20161110133559.GA10191@kroah.com>
Message-ID: <CAK7LNAThxsE3QW4EdPUyxmxbnt_PPjeogi8Fox5AHkddsuu-Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-11-10 22:35 GMT+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Thu, Nov 10, 2016 at 10:24:21PM +0900, Masahiro Yamada wrote:
>>
>> sdhci_alloc_host() returns an error pointer when it fails.
>> but mmc_alloc_host() cannot.
>>
>> This series allow to propagate a proper error code
>> when host-allocation fails.
>
> Why?  What can we really do about the error except give up?  Why does
> having a explicit error value make any difference to the caller, they
> can't do anything different, right?


The error code is shown in the console, like

  probe of 5a000000.sdhc failed with error -12


The proper error code will give a clue
why the driver failed to probe.


> I suggest just leaving it as-is, it's simple, and you don't have to mess
> with PTR_ERR() anywhere.


Why?

Most of driver just give up probing for any error,
but we still do ERR_PTR()/PTR_ERR() here and there.
I think this patch is the same pattern.

If a function returns NULL on failure, we need to think about
"what is the most common failure case".

Currently, MMC drivers assume -ENOMEM is the best
fit for mmc_alloc_host(), but the assumption is fragile.

Already, mmc_alloc_host() calls a function
that returns not only -ENOMEM, but also -ENOSPC.

In the future, some other failure cases might be
added to mmc_alloc_host().

Once we decide the API returns an error pointer,
drivers just propagate the return value from the API.
This is much more stable implementation.



-- 
Best Regards
Masahiro Yamada
