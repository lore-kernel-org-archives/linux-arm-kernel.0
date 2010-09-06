From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 6 Sep 2010 18:17:01 +0900
Subject: [PATCH 3/4] ARM: S5PC110: add common FIMC setup code
In-Reply-To: <4C84AA6D.10509@samsung.com>
References: <1283745044-15514-1-git-send-email-m.szyprowski@samsung.com>
	<1283745044-15514-4-git-send-email-m.szyprowski@samsung.com>
	<AANLkTinhbmKX5gs4TPZwVUX0WSEQ5RLN+_gHAqXsTj1b@mail.gmail.com>
	<4C84AA6D.10509@samsung.com>
Message-ID: <AANLkTikakB1Y6N-UT2Hx+PHfdyticHxCFQzs=uc7KWNc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 6, 2010 at 5:46 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> On 2010-09-06 13:52, Jassi Brar wrote:
>>
>> On Mon, Sep 6, 2010 at 12:50 PM, Marek Szyprowski
>> <m.szyprowski@samsung.com> ?wrote:
>> ....
>>>
>>> + ? ? ? parent = clk_get(NULL, "mout_epll");
>>> + ? ? ? if (IS_ERR(parent))
>>> + ? ? ? ? ? ? ? return PTR_ERR(parent);
>>> +
>>> + ? ? ? for (i = 0; err == 0&& ?i< ?ARRAY_SIZE(fimc_devs); i++) {
>>> + ? ? ? ? ? ? ? if (fimc_devs[i]) {
>>> + ? ? ? ? ? ? ? ? ? ? ? clk_fimc = clk_get(fimc_devs[i], "sclk_fimc");
>>> + ? ? ? ? ? ? ? ? ? ? ? if (IS_ERR(clk_fimc)) {
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? err = PTR_ERR(clk_fimc);
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
>>> + ? ? ? ? ? ? ? ? ? ? ? }
>>> + ? ? ? ? ? ? ? ? ? ? ? clk_set_parent(clk_fimc, parent);
>>> + ? ? ? ? ? ? ? ? ? ? ? clk_put(clk_fimc);
>>> + ? ? ? ? ? ? ? }
>>> + ? ? ? }
>>
>> The sclk_fimc could source clock from a number of options out of a mux.
>> mout_epll is just one of them. Different machines may want to source the
>> clock differently.
>
> Right, I forgot about this case.
>
>> So, IMO the parent selection should not be done in platform code, but
>> rather
>> in machine init code.
>> Not the best, but a better solution can be found in
>> arch/arm/mach-s5pc100/dev-spi.c
>> Give it a thought.
>
> I'm thinking of making the parent clock an argument to the
> s5pv210_fimc_setup_clks().
Yes, that's better since the relevant clock is managed by the CMU

> I really don't like the idea of passing clock name through the platform data
> and letting driver to mess with clock's parents.
In case of SPI the clock mux and scalar is present _within_ the SPI
controller and having to touch SPI regs from outside the driver isn't
what I prefer.

> Machine startup code is the
> last place where such things should be changed.
Until I am enlightened, I'd like to think otherwise.
I think the board designer would already have thought out the clock sourcing
hierarchy. Setting appropriate parents once at boot-time and having drivers
not worry about it, should be better.
