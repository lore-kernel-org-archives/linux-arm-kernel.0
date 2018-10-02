From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Tue, 2 Oct 2018 16:28:49 +0300
Subject: [PATCH v4 2/5] drm/dp: fix link probing for devices supporting
 DP 1.4+
In-Reply-To: <20181001092708.ow4rxgzp4haax76k@qschulz>
References: <1537455288-20223-1-git-send-email-dkos@cadence.com>
 <1537455288-20223-3-git-send-email-dkos@cadence.com>
 <20180921075929.GA28323@intel.com>
 <20181001092708.ow4rxgzp4haax76k@qschulz>
Message-ID: <20181002132849.GR9144@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2018 at 11:27:08AM +0200, Quentin Schulz wrote:
> Hi Manasi,
> 
> On Fri, Sep 21, 2018 at 12:59:30AM -0700, Manasi Navare wrote:
> > Thanks for the patch. Verified with the DP 1.4 spec and looks good to me.
> > Also look at the related patch that makes use of the correct extended capabilities:
> > 
> > https://patchwork.freedesktop.org/patch/249400/
> > 
> 
> If I'm not mistaken, you could get rid of the patch in the Intel driver
> when we have this one merged. Is there any reason not to, have I missed
> something?

i915 (and most other drivers) don't use this code. Also as mentioned in
that thread you should probably validate that the data in the extended
caps looks sane, otherwise the entire point of having it for compatibility
with older source devices is lost.

> 
> Thanks,
> Quentin
> 
> > Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
> > 
> > Manasi
> > 
> > 
> > On Thu, Sep 20, 2018 at 03:54:37PM +0100, Damian Kos wrote:
> > > From: Quentin Schulz <quentin.schulz@free-electrons.com>
> > > 
> > > DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
> > > DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
> > > DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
> > > DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
> > > DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
> > > "true capabilities" of DPRX device.
> > > 
> > > Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
> > > might falsely return lower capabilities to "avoid interoperability
> > > issues with some of the existing DP Source devices that malfunction
> > > when they discover the higher capabilities within those three
> > > registers.".
> > > 
> > > Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
> > > and read 0 so it's safe to check against it even if DP revision is
> > > <1.4
> > > 
> > > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > > Signed-off-by: Damian Kos <dkos@cadence.com>
> > > ---
> > >  drivers/gpu/drm/drm_dp_helper.c | 30 +++++++++++++++++++++++++++++-
> > >  1 file changed, 29 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> > > index 8c6b9fd89f8a..735ebde5c2f0 100644
> > > --- a/drivers/gpu/drm/drm_dp_helper.c
> > > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > > @@ -370,10 +370,38 @@ int drm_dp_link_probe(struct drm_dp_aux *aux, struct drm_dp_link *link)
> > >  {
> > >  	u8 values[3];
> > >  	int err;
> > > +	unsigned int addr;
> > >  
> > >  	memset(link, 0, sizeof(*link));
> > >  
> > > -	err = drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
> > > +	/*
> > > +	 * DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
> > > +	 * DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
> > > +	 * DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
> > > +	 * DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
> > > +	 * DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
> > > +	 * "true capabilities" of DPRX device.
> > > +	 *
> > > +	 * Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
> > > +	 * might falsely return lower capabilities to "avoid interoperability
> > > +	 * issues with some of the existing DP Source devices that malfunction
> > > +	 * when they discover the higher capabilities within those three
> > > +	 * registers.".
> > > +	 *
> > > +	 * Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
> > > +	 * and read 0 so it's safe to check against it even if DP revision is
> > > +	 * <1.4
> > > +	 */
> > > +	err = drm_dp_dpcd_readb(aux, DP_TRAINING_AUX_RD_INTERVAL, values);
> > > +	if (err < 0)
> > > +		return err;
> > > +
> > > +	if (values[0] & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT)
> > > +		addr = DP_DP13_DPCD_REV;
> > > +	else
> > > +		addr = DP_DPCD_REV;
> > > +
> > > +	err = drm_dp_dpcd_read(aux, addr, values, sizeof(values));
> > >  	if (err < 0)
> > >  		return err;
> > >  
> > > -- 
> > > 2.17.1
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel at lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel



> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Ville Syrj?l?
Intel
