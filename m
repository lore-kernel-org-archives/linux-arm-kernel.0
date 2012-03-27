From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 27 Mar 2012 16:17:37 -0700
Subject: [PATCH 09/10] clk: dynamically allocate parent_names basic clk
 registration
In-Reply-To: <20120327194010.GJ29317@pengutronix.de>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
 <1332833009-4121-10-git-send-email-shawn.guo@linaro.org>
 <20120327085514.GI29317@pengutronix.de>
 <20120327125122.GB3719@S2101-09.ap.freescale.net>
 <20120327194010.GJ29317@pengutronix.de>
Message-ID: <CAJOA=zNWvfWX8Qc-f758O1GbO41T00+7umjgk1_N1Tu_KGtwgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 12:40 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Mar 27, 2012 at 08:51:24PM +0800, Shawn Guo wrote:
>> On Tue, Mar 27, 2012 at 10:55:14AM +0200, Sascha Hauer wrote:
>> > On Tue, Mar 27, 2012 at 03:23:28PM +0800, Shawn Guo wrote:
>> > > It's not necessary to have "char *parent[1]" carried in struct clk_gate
>> > > and clk_divider. ?Instead, it can be dynamically allocated in
>> > > registration function, just like what clk_register_fixed_rate does.
>> >
>> > I patched it the way it is to get rid of the additional malloc which
>> > seemed unnecessary. Maybe the real question is whether the core should
>> > duplicate the parent strings instead of the basic clock types.
>> >
>> If we can ensure the parent strings will only be used during
>> clk_register call, we do not need to duplicate the parent strings.
>>
>> But right now the parent strings is used not only in clk_register call
>> but also __clk_set_parent for finding parent index in case the search
>> on cached parent points fails. ?I guess Mike has a good reason for that.

I'd like to think my reasons are good ;-)

The common clk framework pulls together clock data from many sources,
and we can never assume that the tree of struct clk's is "complete".
For example an on-SoC multiplexer clock might have one input from an
external PMIC.  It is conceivable that clock data / common clk support
for that PMIC isn't yet merged.  Should that prevent the on-SoC mux
clock from using that source via clk_set_parent?  Absolutely not.
That is why the parent_names arrays are necessary.  They represent
"complete" data even in the absence of actual clock data.  Using only
the index of the array the .set_rate callback should be able to do the
[register write | i2c command | whatever] in order to switch to the
PMIC source.  The rate will be unknown, but at least the operation is
possible.

> Probably. That's why I suggest to copy the strings in the framework.
> Then we do not have to duplicate the code to copy the strings and also
> make sure that the core works on its own strings.

Copying the strings in the fwk is sensible.  I'll throw together a
patch which takes in the const char *parent_name and passes that to
clk_register directly, which builds up the char **parent_names itself.

Regards,
Mike
