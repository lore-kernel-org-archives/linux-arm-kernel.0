From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 4 Mar 2016 11:03:49 +0800
Subject: [PATCH v2 1/5] thermal: change "hysteresis" as optional property
In-Reply-To: <20160303162942.GA2445@localhost.localdomain>
References: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
 <1456458227-12950-2-git-send-email-leo.yan@linaro.org>
 <20160303162942.GA2445@localhost.localdomain>
Message-ID: <20160304030349.GA11012@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo,

On Thu, Mar 03, 2016 at 08:29:44AM -0800, Eduardo Valentin wrote:
> Hi Leo,
> 
> On Fri, Feb 26, 2016 at 11:43:43AM +0800, Leo Yan wrote:
> > The property "hysteresis" is mandatory for trip points, so if without
> > it the thermal zone cannot register successfully. But "hysteresis" is
> > ignored in the thermal subsystem and only inquired by several thermal
> > sensor drivers.
> 
> I am not sure this a good direction to go. Remember that Linux
> implementation not necessarily has to be the implication of the DT
> binding. Hysteresis is a property that plays a significant role on
> thermal control systems, which in many cases avoid overshooting cooling
> actions. Having the DT writer to explicitly set it to 0 means that zone
> does not suffer of overshooting and does not need hysteresis.

After review current code, the "hysteresis" is used to calculate
temperature falling threshold with a more conservative value; so that
finally avoid overshooting issue.

Please confirm if is my understanding correct or not?

> If the Linux thermal subsystem has a problem with handling hysteresis, I
> would rather fix Linux code than relaxing the DT binding. Or if you
> still believe hysteresis is really optional, I would prefer to see a
> better justification than "Linux ignores it".

If we think about power allocator governor, PID's two parameters are
also used to dismiss overshooting issue: one is k_po (proportional
term), another is k_i (integral term). So that means after we apply
power allocator governor, we don't need parameter "hysteresis" due PID
algorithm can automatically dismiss potential errors.

Does this make sense?

Thanks,
Leo Yan
