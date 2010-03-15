From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 15 Mar 2010 12:02:14 +0530
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <1b68c6791003142241q274b573dl3e60bf25be462e68@mail.gmail.com>
References: <4B9DB823.1040809@st.com>	
	<1b68c6791003142147y200fff12vc805fbd07f1c0ef4@mail.gmail.com>	
	<4B9DC239.90407@st.com>
	<1b68c6791003142241q274b573dl3e60bf25be462e68@mail.gmail.com>
Message-ID: <4B9DD46E.7060704@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2010 11:11 AM, jassi brar wrote:
> On Mon, Mar 15, 2010 at 2:14 PM, Shiraz HASHIM <shiraz.hashim@st.com> wrote:
>> Hello Jassi,
>>
>> On 3/15/2010 10:17 AM, jassi brar wrote:
>>> On Mon, Mar 15, 2010 at 1:31 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
>>>> In our SOC's (SPEArxxx), we have many peripheral sharing PL_GPIO pins and so
>>>> only few peripherals can be selected in a configuration. This is configurable
>>>> using a set of registers. Now the problem is to make following work:
>>>>
>>>> 1. How to do this selection in kernel in a simple way?
>>>> 2. Based on this selection hardware registers needs to be configured.
>>> Why can't you make the drivers acquire and setup the necessary pins during
>>> probe?
>>> Among other benefits, it enables you to use the same kernel image and device
>>> drivers as modules -- if a GPIO can be used by two different device
>>> controllers, you
>>> can switch the 'mode' of the board by simple rmmod-insmod
>>
>> I think the problem is we cannot change the standard drivers (already in the
>> mainline). So if the standard driver doesn't support this in its probe, then
>> how should we manage this?
> Though the drivers should already have done that, but still you can always
> submit patches to improve.
> 
>> Further these configurations are board dependent, so I think driver must be
>> independent of this.
> Don't really understand this. Viresh said that the SoC can configure GPIOs for
> a controller or the other, which is quite common and is handled during probe.
> Also, it's desirable to have one kernel image run on many machines with the
> same SOC.
> 

Actually, different peripherals share IO Pads (PL_GPIOs) and GPIO lines. Sending
patch for drivers to support this doesn't look a great idea to me. Further this 
may cause problems to users, for example: User have entered a inserted a module
and by mistake or lack of knowledge, he disables already working IP. Now with 
Kconfig concept this is taken care of at the beginning only. User can't select
peripherals which can't be enabled simultaneously.
