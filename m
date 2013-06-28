From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 28 Jun 2013 10:17:57 +0200
Subject: [linux-sunxi] [PATCH 0/8] clocksource: sunxi: Timer fixes and
 cleanup
In-Reply-To: <20130627232608.1174558b@i7>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
 <51CC0566.8010302@redhat.com> <20130627094307.GC8437@lukather>
 <51CC0BC3.5090309@redhat.com> <20130627165436.GB4319@lukather>
 <20130627232608.1174558b@i7>
Message-ID: <51CD46B5.6090101@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/27/2013 10:26 PM, Siarhei Siamashka wrote:
> On Thu, 27 Jun 2013 18:54:36 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>
>> On Thu, Jun 27, 2013 at 11:54:11AM +0200, Hans de Goede wrote:
>>> I notice that unlike the sunxi-3.4 code you don't do any locking,
>>> so how do you stop 2 clocksource calls from racing (and thus
>>> getting a possible wrong value because of things not
>>> being properly latched) ?
>>
>> Hmm, right. I'll add a spinlock.
>
> I think the best would be to ask the Allwinner people (it's good to
> have them in CC, right?) whether anything wrong can happen because of
> "things not being properly latched".
>
> The A10 manual from http://free-electrons.com/~maxime/pub/datasheet/
> does not seem to contain any details about what bad things may happen
> if we try to read CNT64_LO_REG while latching is still in progress and
> CNT64_RL_EN bit in CNT64_CTRL_REG has not changed to zero yet.
> I can imagine the following possible scenarios:
>    1. We read either the old stale CNT64_LO_REG value or the new
>       correct value.
>    2. We read either the old stale CNT64_LO_REG value or the new
>       correct value, or some random garbage.
>    3. The processor may deadlock, eat your dog, or do some other
>       nasty thing.
>
> In the case of 1, we probably can get away without using any spinlocks?

No, because if ie CNT64_LO_REG old is 0xffffffff and CNT64_LO_REG new is
say 0x00000001, and we do get the new CNT64_HI_REG things will break.

Regards,

Hans
