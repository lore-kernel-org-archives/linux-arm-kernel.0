From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 25 Aug 2015 14:07:04 -0700
Subject: [RESEND PATCH v16 4/4] ARM: dts: add the support power-domain
 node on RK3288 SoCs
In-Reply-To: <1440487486-6154-5-git-send-email-wxt@rock-chips.com> (Caesar
 Wang's message of "Tue, 25 Aug 2015 15:24:46 +0800")
References: <1440487486-6154-1-git-send-email-wxt@rock-chips.com>
 <1440487486-6154-5-git-send-email-wxt@rock-chips.com>
Message-ID: <7hfv37axhj.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar Wang <wxt@rock-chips.com> writes:

> We can add more domains node in the future.
> This patch add the needed clocks into power-controller.
> As the discuess about all the device clocks being listed in
> the power-domains itself.
>
> There are several reasons as follows:
>
> Firstly, the clocks need be turned off to save power when
> the system enter the suspend state. So we need to enumerate
> the clocks in the dts. In order to power domain can turn on and off.

Yes, but this is the job of device drivers which are runtime PM adapted
to gate their own clocks.  I agree these clocks need to be enumerated in
the DTS, but they should be in the device nodes.

> Secondly, the reset-circuit should reset be synchronous on RK3288,
> then sync revoked. So we need to enable clocks of all devices.
> In other words, we have to enable the clocks before you operate them
> if all the device clocks are included in someone domians.

Yes, this is pretty common for reset.  

> Someone wish was to get the clocks by reading the clocks from the
> device nodes, We can do that but we can solve the above issues.

I don't follow this sentence.  Are you saying doing that will not solve
the above issues?  Why not?  Please explain.

If there are non-device clocks that also need to be enabled before
asserting reset, then those are candidates for the power-domain node,
but not device clocks.

> Anyway, the best ideas we can fix it in the future SoCs.

I don't think this is an SoC design issue as this is needed when you
have synchronous reset.  My concern is primarily around how to describe
this in the DT.

Kevin
