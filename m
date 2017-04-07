From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Fri, 7 Apr 2017 13:51:52 +0300
Subject: [RFC 4/8] regulator: core: Check enabling bypass respects
 constraints
In-Reply-To: <20170406185202.uixxcv3dgucrddgc@sirena.org.uk>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez@nxp.com>
 <20170324125212.vikgekqxsnu7htzl@sirena.org.uk>
 <1490704781.3546.57.camel@nxp.com>
 <20170328164754.z2c2ttovs3sxbcos@sirena.org.uk>
 <1490730595.15830.1.camel@nxp.com>
 <20170406185202.uixxcv3dgucrddgc@sirena.org.uk>
Message-ID: <1491562312.9365.41.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-04-06 at 19:52 +0100, Mark Brown wrote:
> On Tue, Mar 28, 2017 at 10:49:55PM +0300, Leonard Crestez wrote:
> > On Tue, 2017-03-28 at 17:47 +0100, Mark Brown wrote:

> > > To repeat what I said previously the whole point of bypassing is to not
> > > do regulation and generally the constraints in the unregulated idle case
> > > are substantially more relaxed.??This would break use cases relying on
> > > the existing behaviour which wouldn't expect to affect the parent
> > > voltage at all, either stopping things working or making them less
> > > efficient by needlessly regulating the voltage down which defeats the
> > > main point of bypassing.

> > So what you want is to prevent voltage changes unless strictly
> > required, even lowering? What I want is to get the minimum voltage in
> > the SOC because that's where power is being consumed.

> So your end goal here is to bypass a regulator which is forced into your
> system design by being integrated into the SoC which isn't able to
> regulate down to a low enough voltage for your use case???I guess one
> question is if you need to use the regulator at all?

Both the PMIC and the LDOs can provide the required voltage range. LDO
bypass mode is a design tradeoff: the PMIC provides more efficient
conversion but with more fluctuations.

My question was about how the regulator framework handles constraints
and consumer voltage requests. What I want is for the output to be set
to the minimum value that meets all constraints. Maybe other users
would prefer regulators to keep their output as much as possible?

This is relevant even if LDOs are enabled, it's still preferable to
have PMIC output as low as possible because then less of the voltage
reduction is performed in the LDO.

It currently seems to work how I expect but from your statement it's
not clear if it's entirely intentional.

> > It's not at all obvious that in bypass mode the output constraints of a
> > regulator need not be respected by the core. I expected the opposite,
> > this is something that should be documented.

> SubmittingPatches...??Bear in mind that most regulators are fixed
> voltage in a given system so bypass would be very difficult to use if it
> tried to pass the constraints upstream.

> > But if the bypassed regulator has a downstream consumer then it's
> > requirements should definitely still be met in bypass mode, right? I
> > could set my maximum voltage directly from cpufreq in that case.

> What we're interpreting bypass mode as meaning is "stop regulating".
> There will still be some limits but we're expecting them to be enforced
> in the extremes of the constraints in the parent regulators.

> > Or should a bypassed regulator ignore all other requests? One of the
> > behaviors that this patch series relies on is that calling set_voltage
> > on a bypassed regulator propagates this request to the supply and picks
> > the minimum voltage there. An alternative implementation would be to

> Yes, the expectation is that if anything is being changed it won't have
> any effect until regulation is reenabled but we're not particularly
> expecting much activity on bypassed regulators.

OK, so it is up to consumers to ensure the supply voltage is acceptable
before allowing bypass. If they want to do something clever they should
register as a consumer to the supply as well.

> > 
> > call set_voltage directly on the supply regulator by changing the
> > "{arm,soc,pu}-supply" references in DT to point to the PMIC instead.
> > Would that be better?

> That's more what's expected here.

Ok, I will try that approach instead.

> > Both approaches work. Relying on propagation feels like it is the
> > "right way" to handle this, even if it's harder to get right and the
> > regulator core does not entirely support it. But it's possible that
> > this is based on a misunderstanding of what "bypass" is actually
> > supposed to do.

> Another option would be to add a regulator configuration which allowed
> the regulator to transparently go into bypass mode if the parent could
> do things directly, only enabling regulation if the parent couldn't
> support.??That would mean you'd loose the supply cleanup function which
> is typically part of why there are LDOs in the system but it sounds like
> you're OK with that in at least your use case.

Dynamic enabling of bypass mode in the core seems very complex and not
terribly useful for my case. I pretty much want them always in bypass
or always enabled.
