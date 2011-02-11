From: andreiw@motorola.com (Andrei Warkentin)
Date: Fri, 11 Feb 2011 16:27:51 -0600
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <AANLkTimjQfuNU-_rZTjAPrjxJhb=3kReVysBKoPE6Q4o@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<AANLkTimjQfuNU-_rZTjAPrjxJhb=3kReVysBKoPE6Q4o@mail.gmail.com>
Message-ID: <AANLkTi=a1SbU4cn-m7r2BH2KhNoad3H9e41AcXoViMm7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 9, 2011 at 2:37 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> [Quoting in verbatin so the orginal mail hits linux-mmc, this is very
> interesting!]
>
> 2011/2/8 Andrei Warkentin <andreiw@motorola.com>:
>> Hi,
>>
>> I'm not sure if this is the best place to bring this up, but Russel's
>> name is on a fair share of drivers/mmc code, and there does seem to be
>> quite a bit of MMC-related discussions. Excuse me in advance if this
>> isn't the right forum :-).
>>
>> Certain MMC vendors (maybe even quite a bit of them) use a pretty
>> rigid buffering scheme when it comes to handling writes. There is
>> usually a buffer A for random accesses, and a buffer B for sequential
>> accesses. For certain Toshiba parts, it looks like buffer A is 8KB
>> wide, with buffer B being 4MB wide, and all accesses larger than 8KB
>> effectively equating to 4MB accesses. Worse, consecutive small (8k)
>> writes are treated as one large sequential access, once again ending
>> up in buffer B, thus necessitating out-of-order writing to work around
>> this.
>>
>> What this means is decreased life span for the parts, and it also
>> means a performance impact on small writes, but the first item is much
>> more crucial, especially for smaller parts.
>>
>> As I've mentioned, probably more vendors are affected. How about a
>> generic MMC_BLOCK quirk that splits the requests (and optionally
>> reorders) them? The thresholds would then be adjustable as
>> module/kernel parameters based on manfid. I'm asking because I have a
>> patch now, but its ugly and hardcoded against a specific manufacturer.
>
> There is a quirk API so that specific quirks can be flagged for certain
> vendors and cards, e.g. some Toshibas in this case. e.g. grep the
> kernel source for MMC_QUIRK_BLKSZ_FOR_BYTE_MODE.
>
> But as Russell says this probably needs to be signalled up to the
> block layer to be handled properly.
>
> Why don't you post the code you have today as an RFC: patch,
> I think many will be interested?
>
> Yours,
> Linus Walleij
>

I think it's worthwhile to make make the upper block layers aware of
MMC (and apparently other flash memory) limitations, but I think as a
first step it could make sense (for me) to reformat the patch I am
attaching into something that looks better.

Don't take the attached patch too seriously :-).

Thanks,
A
-------------- next part --------------
A non-text attachment was scrubbed...
Name: toshiba_emmc_opt.patch
Type: text/x-diff
Size: 8737 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110211/426789b7/attachment.bin>
