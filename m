From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Tue, 3 Nov 2015 17:49:03 +0100
Subject: [PATCH] lightnvm: work around 32-bit built error
In-Reply-To: <5638D1F0.7060406@fb.com>
References: <4925999.tpkPGVQaeU@wuerfel> <5638D1F0.7060406@fb.com>
Message-ID: <5638E57F.9090905@lightnvm.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2015 04:25 PM, Jens Axboe wrote:
> On 11/03/2015 06:53 AM, Arnd Bergmann wrote:
>> The newly added lightnvm incorrectly uses a sector_t variable to
>> represent a data structure with fixed length bit fields, which breaks
>> when sector_t is configured to be 32-bit:
>>
>> In file included from ../drivers/lightnvm/core.c:29:0:
>> /include/linux/lightnvm.h:143:4: error: width of 'resved' exceeds its
>> type
>>      sector_t resved  : 36;
>> include/linux/lightnvm.h: In function 'ppa_set_empty':
>> /include/linux/lightnvm.h:120:20: warning: large integer implicitly
>> truncated to unsigned type [-Woverflow]
>>   #define ADDR_EMPTY (~0ULL)
> 
> Thanks Arnd, Matias sent another variant yesterday that changes this to
> u64 as well.
> 
>> This patch resolves the build error, but does not address the fact that
>> bit fields are not reliable in data structures that are interpreted
>> by firmware on another architecture. If the layout is meant to be
>> stable, the bit fields should be replaced with explicit calculations.
> 
> Matias? Are these every stored and read back, potentially on a different
> machine?
> 

They are only used for translation from the generic ppa to the device
specific ppa in the host. They will not be stored in the device (if, it
would be in done with another structure)
