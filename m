From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Sep 2012 14:05:28 -0600
Subject: [RFC PATCH 0/3] ARM: use C pre-processor with dtc
In-Reply-To: <1348603151.5565.20@snotra>
References: <1348603151.5565.20@snotra>
Message-ID: <50620E88.4@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2012 01:59 PM, Scott Wood wrote:
> On 09/25/2012 02:51:27 PM, Mark Brown wrote:
>> On Tue, Sep 25, 2012 at 02:35:46PM -0500, Scott Wood wrote:
>>
>> > Do you have an example of where you'd actually benefit from this?
>> > I'd think most things could either be done reasonably well with
>> > what's built into DTC (see what we've done in
>> > arch/powerpc/boot/dts/fsl), or would need math expression support in
>> > DTC (or has that been added?).
>>
>> The constant example is the magic numbers we need to embed into DTs for
>> things like interrupt modes, making them human readable would be a real
>> win.
> 
> Wasn't there a patch for named constant support in dtc a while back?
> Hmm:
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-January/011184.html

Yes. There has basically been zero traction on that front. I'm trying to
push a scheme that requires minimal changes to dtc itself in the hope
that will move /something/ forward at greater than zero speed.

> I'm not sure that going down the CPP path is better than the possibility
> of named constants having a different syntax from macros/functions.

I've come around to thinking that using something external to dtc is
actually very advantageous. The main benefit here is that a C-syntax
(well, cpp-syntax) header file can be included by both DT code and C
code, and hence there's no need to duplicate the constant definitions.
Equally, this way, anyone is free to go ahead and use whatever tools
they want for the pre-processing; as long as a valid DT comes out the
end of it, dtc can eat it. This gives us flexibility to change solutions
without having to change dtc. Plus, we don't all have to be
language-lawyers and invent yet another language inside dtc; all the
parts are already written for us, except for a tiny amount of glue.
