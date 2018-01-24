From: briannorris@chromium.org (Brian Norris)
Date: Wed, 24 Jan 2018 10:14:49 -0800
Subject: [PATCH v1 2/2] drm/bridge/synopsys: dsi: Add a warning msg on
 dsi read operations
In-Reply-To: <369181f6-1bb4-0559-86c9-5528be7fc459@st.com>
References: <20180123142618.28384-1-philippe.cornu@st.com>
 <20180123142618.28384-3-philippe.cornu@st.com>
 <CA+ASDXPJ9uPDwRhP2WbazjeT6o=6L0ttffWXjwjkD3KxB+1cuQ@mail.gmail.com>
 <369181f6-1bb4-0559-86c9-5528be7fc459@st.com>
Message-ID: <20180124181449.2fi5l3wdllvxn5re@ban.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On Wed, Jan 24, 2018 at 01:22:04PM +0000, Philippe CORNU wrote:
> On 01/23/2018 10:28 PM, Brian Norris wrote:
> > I see you sent this out already today, while I only just responded
> > (late) to your questions about it... oh well :)
> > 
> 
> I got a short period to clean-up and adds features to this driver (1.31 
> ip version + maybe the read feature), sorry to have not wait a single 
> day more.

No problem. The key word was "late"; my mail was buried enough I just
missed responding. Not your fault!

> > On Tue, Jan 23, 2018 at 6:26 AM, Philippe Cornu <philippe.cornu@st.com> wrote:
> >> The DCS/GENERIC DSI read feature is not yet implemented so it
> >> is important to warn the host_transfer() caller in case of
> >> read operation requests.
> >>
> >> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> >> ---
> >>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 9 ++++++++-
> >>   1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> >> index 096cf5e5bb30..e46ddff8601c 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> >> @@ -417,7 +417,14 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
> >>          if (ret)
> >>                  return ret;
> >>
> >> -       nb_bytes = packet.size;
> >> +       if (msg->rx_buf && msg->rx_len > 0) {
> > 
> > It feels like you should do this check *before* you start writing
> > anything. It's possible to have a combination TX/RX command, and it
> > would be counterintuitive to only do half the operation then return
> > with an argument error.
> > 
> 
> Many thanks for your review.
> 
> I agree with your comments.
> 
> Well, my patch is not good at all because it contains a small part of 
> the read feature I am writing... but it is not the purpose of this patch.
> 
> No excuse, sorry guys for making you waste time.

No worries. These weren't that bad anyway, just a little suboptimal :)

> I will re-write a new patch 100% decorrelated from a possible future 
> read feature.

Yeah, that would probably work best. It's hard to write and review good
"intermediate" code; we should write it as if the code will last as-is.

> I could also wait until I have a working read feature but as it could 
> take some times, I prefer warning users asap.

Sounds good.

[snip]

Thanks,
Brian
