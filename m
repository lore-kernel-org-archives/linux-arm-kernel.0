From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Mon, 15 Oct 2018 09:12:28 -0600
Subject: [PATCH 6/9]  PM / OPP: dt-bindings: Add opp-interconnect-bw
In-Reply-To: <20181015143420.GA16932@bogus>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-7-jcrouse@codeaurora.org>
 <20181015143420.GA16932@bogus>
Message-ID: <20181015151228.GB4751@jcrouse-lnx.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 09:34:20AM -0500, Rob Herring wrote:
> On Mon, Aug 27, 2018 at 09:11:09AM -0600, Jordan Crouse wrote:
> > Add the "opp-interconnect-bw" property to specify the
> > average and peak bandwidth for an interconnect path for
> > a specific operating power point. A separate bandwidth
> > pair can be specified for each of the interconnects
> > defined for the device by appending the interconnect
> > name to the property.
> > 
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >  Documentation/devicetree/bindings/opp/opp.txt | 36 +++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index c396c4c0af92..d714c084f36d 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -170,6 +170,11 @@ Optional properties:
> >    functioning of the current device at the current OPP (where this property is
> >    present).
> >  
> > +- opp-interconnect-bw-<name>: This is an array of pairs specifying the average
> > +  and peak bandwidth in bytes per second for the interconnect path known by
> > +  'name'.  This should match the name(s) specified by interconnect-names in the
> > +  device definition.
> > +
> 
> I don't think this is good design with the name defined in one node and 
> then used in the OPP table. First, '*-names' is typically the a name 
> local to that node/device. If you had 2 instances of a device with a 
> shared OPP table for the 2 instances, then you are going to have to 
> make the names unique. Second, how exactly would having multiple b/w 
> entries work? A given OPP frequency supports the sum of the b/w entries? 
> What if some devices for b/w entries aren't currently active?

For device that is fully scalable a given OPP frequency could need a
different quota for multiple interconnect entries - each one would be
programmed individually, something like this:

set_opp() {
    set_device_frequency(opp);
    for each interconnect name {
        get_device_bw(opp, name);
	icc_set(name, bw);
    }
}

And the naming scheme gives you the flexibility to choose the icc names
you need.  For example if port0 was always fixed and port1 scaled you could
specify the b/w for port1 without having to also have a dummy vote for port0.

The main reason I included the names was that I felt it had a potential to
be confusing if we used absolute indexes or some other implied scheme - at
least for the driver developer it makes slightly more sense to look up the
bandwidth for "port0" with the same name you used to register the interconnect.

> This also seems like a mixture of using OPP table for setting GPU's 
> bandwidth/freq and then the interconnect binding to set the 
> interconnect's bandwidth. Perhaps we need a more unified approach. Not 
> sure what that would look like though.

In a perfect world the interconnect(s) would be left to scale on their own
and they wouldn't be tied to an individual device frequency. But that would
involve significantly more infrastructure for a given device.

Also in RE to our other discussion with Viresh on the qcom,level for the
GPU; the GPU frequency vote is done by the microcontroller but the
interconnect bandwidth is set by the CPU on the sdm845 so we're already
not unified by design. There could be something out there that uses
magic and callbacks but I also don't know what that looks like.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
