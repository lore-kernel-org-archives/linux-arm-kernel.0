From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 11 Nov 2016 01:25:12 -0300
Subject: [PATCH v5 02/23] of: device: Export of_device_{get_modalias,
 uvent_modalias} to modules
In-Reply-To: <CAGb2v66H1doBOdPPN9kz1vdNYx8gpgkF6s3UhTiXCCp0RZYKwg@mail.gmail.com>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018015636.11701-3-stephen.boyd@linaro.org>
 <CAGb2v66t8t3o0PxzaaBKnRvNP=CWG5nYud7Wjp27Q1x2baM4hg@mail.gmail.com>
 <147733850401.29612.2343965740004706258@sboyd-linaro>
 <20161025011632.GA23876@b29397-desktop>
 <147829269430.21688.2345895151880009021@sboyd-linaro>
 <20161107012920.GA10559@b29397-desktop>
 <CAGb2v66C15fU1b2+xNDV8Fv2kmmKXyUknA8=9wXztUcs8CNKLg@mail.gmail.com>
 <CAL_Jsq+Bw4XVEJY6V4Hn+D_OmqEcp_nLLrVT0_i+jX_guCqzfA@mail.gmail.com>
 <CAGb2v66H1doBOdPPN9kz1vdNYx8gpgkF6s3UhTiXCCp0RZYKwg@mail.gmail.com>
Message-ID: <CABxcv==64RGB0U5dd_B8w6H0gpcscJ1Yr0i=iXrLDfN5W2K-tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello ChenYu

On Fri, Nov 11, 2016 at 12:01 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Fri, Nov 11, 2016 at 5:42 AM, Rob Herring <robh@kernel.org> wrote:

[snip]

>>
>> Do you have patches using this already. If not, it is starting to get
>> a bit late for v4.10.
>>
>> I can apply this, but then you'll just be pulling in other DT patches.
>
> Not sure what you mean by "using" this...
>
> I have patches which use this to add DT-based modalias entries for
> module auto-loading to i2c and sunxi-rsb that I haven't sent.
>

Unfortunately the I2C core can't be changed without breaking a lot of
I2C drivers that are relying on the current behavior. I've already
posted a RFC patch [0] for I2C that does this about a year ago and
enumerated the issues that have to be addressed before the change can
be made (and fixed some of the issues mentioned) on this series [1].

Another issue is that an I2C device ID table is a requirement anyways
since I2C drivers expect an i2c_device_id as an argument of their
probe function. Kieran already have patches [2] to change that which
should land soon.

I plan to fix the remaining I2C drivers once his patches are merged
and re-post the RFC patch as a proper one.

> As far as DT usage goes, we already need this for the axp20x mfd driver.
> There are 2 variants, i2c and sunxi-rsb. For the I2C variant a fix was
> sent to fix module auto-loading by using the I2C client ID table:
>
>     mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
>     https://git.kernel.org/cgit/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=b7142a19321484bd7681aa547c1d50148c8e2825
>

Yes, this is the workaround used by most DT-only I2C drivers. The only
reason that these drivers have an I2C device ID is due the
restrictions imposed by the I2C core.

Best regards,
Javier
