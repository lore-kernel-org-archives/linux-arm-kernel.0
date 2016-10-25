From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue, 25 Oct 2016 16:57:17 +0200
Subject: [PATCH/RFT v2 09/17] regulator: fixed: Add over current event
In-Reply-To: <20161025143304.GW17252@sirena.org.uk>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-10-ahaslam@baylibre.com>
 <20161024175320.GO17252@sirena.org.uk>
 <CAKXjFTNZhWTZSXtLZo8EieBtAPn_J-MM+-g8yCRJiV6UBspB9Q@mail.gmail.com>
 <20161024181937.GP17252@sirena.org.uk>
 <CAKXjFTOHcqRFtbXMXSTyUZ3P00eRMz1N3d62Y3NWVZJDGeScZA@mail.gmail.com>
 <20161025143304.GW17252@sirena.org.uk>
Message-ID: <CAKXjFTOz=TGCiKic77JXdJMUoobLY4Ye9QnqajbG4JTh=VGUFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 4:33 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Oct 25, 2016 at 02:55:48PM +0200, Axel Haslam wrote:
>
>> To be able to use regulator to handle the overcurrent pin, i need to be able
>> to somehow retrieve the over current pin state from the regulator driver.
>
> What makes you say that, none of the existing users need this?
>
>> As i was trying your suggestion, i remembered why i thought i should use
>> mode instead of status: Status seems to be for internal regulator driver use,
>> there is no regulator_get_status, function and REGULATOR_STATUS_* are defined
>> in driver.h and not in consumer.h as  REGULATOR_MODE_*
>
>> Would you be ok if i allow consumers to get the status via a new
>> "regulator_get_status" call?
>
> What would they do with this information that they can't do with the
> existing error notification?

the usb core relies in two flags that need too be set properly, one is the
over-current indicator RH_PS_POCI , and the other is the over current
indicator "change" (RH_PS_OCIC).

The idea was to use the notification to set the over current indicator
"change" flag,
which will happen for both rising and falling edges. And to use
get_status or get_mode
to set the over-current indicator flag which should reflect the actual
pin status.


-Axel.
