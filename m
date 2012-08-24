From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 23 Aug 2012 21:34:41 -0600
Subject: [PATCH v2 1/9] pinctrl: mvebu: pinctrl driver core
In-Reply-To: <5036B639.20608@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1345623750-10645-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <5035445B.6000500@wwwdotorg.org>
 <CABJ1b_Tdr80DGqb-FRzwDbF3m7g6fBguk5GtRAfRUYx5Sqy_cA@mail.gmail.com>
 <50366E44.4030606@wwwdotorg.org> <50369305.6050304@gmail.com>
 <50369FEE.8000003@wwwdotorg.org> <5036B639.20608@gmail.com>
Message-ID: <5036F651.4020700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2012 05:01 PM, Sebastian Hesselbarth wrote:
> On 08/23/2012 11:26 PM, Stephen Warren wrote:
>> As you may have guessed, I strongly prefer the hard-coded static table
>> based approach, or at least separating the definition of known
>> pins/groups/functions from the configuration nodes that define which
>> particular mux settings to actually use.
>>
>> Puting this all a little more simply, the pinctrl core wants to generate
>> a list of all known functions. It is a single global/unified list. It
>> first calls pinmux_ops.get_functions_count() to find out how many
>> functions there are in the list, then pinmux_ops.get_function_name() for
>> each one to find its name, then pinmux_ops.get_function_groups() to find
>> out which groups allow that function to be mux'd onto them.
> 
> Ok, now this becomes a little bit more clear to me.
> 
> Consider uart1 on dove is muxable to:
> mpp2 uart1(rts), mpp3 uart1(cts), mpp21 uart1(rts), mpp22 uart1(cts),
> and finally mpp_uart1(rx and tx).
> 
> So possible, valid combinations for uart1 would be:
> (a) mpp_uart1;
> (b) mpp_uart1, mpp2, mpp3;
> (c) mpp_uart1, mpp21, mpp22;
> (d) mpp_uart1, mpp2, mpp22;
> (e) mpp_uart1, mpp21, mpp3;
> 
> Now what we currently do is, use DT to setup all known functions with e.g.
> marvell,pins = "mpp_uart1", "mpp2", "mpp22" and marvell,function = "uart1".
> This requires to count all pinctrl DT node children to count the known
> functions that can ever be muxed to. It will never allow to mux uart1 to sw
> flow control during run-time when there was no DT child node for it.

In the example above, there is a single function named "uart1". If this
was all the HW supported, I'd expect the driver's
pinmux_ops.get_functions_count() to return 1,
pinmux_ops.get_function_name(0) to return "uart1", and
pinmux_ops.get_function_name(n>0) to return an error.

In practice, I assume there are many other options that can be muxed
onto mpp2/3/21/22/uart1, so they'd be included in the list as well.

> But you are proposing to scan the list passed from SoC specific driver
> for all
> possible marvell,function ("uart1", "uart2", "sdio0", ...) and build up
> lists
> of pingroups that can be used with this specific marvell,function; or
> even build
> up lists of pingroups that allow uart1(rts), and another one for
> uart1(cts), ...?

I don't expect any scanning, no. I'd expect that tables provided by the
SoC-specific drivers to be:

* A table of pins
* A table of groups
* A table of functions

No scanning involved.
