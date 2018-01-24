From: briannorris@chromium.org (Brian Norris)
Date: Wed, 24 Jan 2018 10:37:49 -0800
Subject: [PATCH v1 1/2] drm/bridge/synopsys: dsi: Fix dsi_host_transfer()
 return value
In-Reply-To: <4a1b0208-3187-2f08-69fe-ca3b77ee88a8@st.com>
References: <20180123142618.28384-1-philippe.cornu@st.com>
 <20180123142618.28384-2-philippe.cornu@st.com>
 <CA+ASDXNDpmVdARLCD-A6nfADgmomuscpwekb8M-j=MFJhpeC4Q@mail.gmail.com>
 <4a1b0208-3187-2f08-69fe-ca3b77ee88a8@st.com>
Message-ID: <20180124183748.l5iqoiyqxy4o2pyk@ban.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On Wed, Jan 24, 2018 at 01:33:54PM +0000, Philippe CORNU wrote:
> On 01/23/2018 10:38 PM, Brian Norris wrote:
> > Hi Philippe,
> > 
> > On Tue, Jan 23, 2018 at 6:26 AM, Philippe Cornu <philippe.cornu@st.com> wrote:
> >> The dw_mipi_dsi_host_transfer() must return the number of
> >> bytes transmitted/received on success instead of 0.
> > 
> > I'm a little confused. As of the latest drm-misc-next I'm looking at,
> > this still has conflicting documentation.
> > 
> > For ->transfer():
> > 
> > On success it shall return the number of bytes
> >   * transmitted for write packets or the number of bytes received for read
> >   * packets.
> > 
> > While mipi_dsi_generic_read() says:
> > 
> >   * Return: The number of bytes successfully read or a negative error code on
> >   * failure.
> > 
> > But it just returns the value that ->transfer() returns.
> > 
> 
> Not sure to follow you here: mipi_dsi_generic_read() will trig a dsi 
> generic read so it has to return "the number of bytes received for read 
> packets" as explained for the ->transfer() function... so it looks 
> "coherent"...
> 
> But maybe you want to point out something different?

Actually, reading back what I wrote, I'm not sure it made sense. I think
*I* was confusing "supporting TX only" with "supporting TX and RX". I
believe the documentation isn't conflicting, but your current patch is a
little misleading.

With your current patch, you're returning the 'mipi_dsi_packet::size',
which is the sum of both TX and RX. Since we only support TX right now,
I suppose that actually is fine (because 'rx_len == 0'). But if we start
supporting RX too, then this field is not the right one to return.

Anyway, maybe this patch was fine as it was. But when you get RX
support, this will have to be something like:

	if (msg->rx_len)
		return msg->rx_len;
	else
		return packet.size;

BTW, does anyone actually care about seeing the number of TX bytes
returned? That seems weird, because I wouldn't expect you'd get a good
result from a partial TX (dunno about partial RX). And I also see that
there are other drivers that get this all wrong too. See
mtk_dsi_host_transfer(), which only returns 0 for TX and 'recv_cnt' for
RX.

So all-in-all, maybe my problem isn't that the documentation is
conflicting, exactly, but that the requirements are somewhat odd, such
that either implementations get it wrong (2 of 3 that I've looked at!),
or they have to write somewhat odd special-casing.

> > So I'm not sure whether the documentation is still wrong, or if the
> > implementation is.
> > 
> > Anyway, I guess maybe that isn't super-critical to *this* patch, since
> > we don't have RX support yet...
> > 
> 
> The main reason why I want to "fix" this is because I do not want to 
> explain to our customers (writing dsi panel drivers) why we have a 
> different returned value compare to other platforms : )

Brian
