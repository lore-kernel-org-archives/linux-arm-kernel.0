From: briannorris@chromium.org (Brian Norris)
Date: Tue, 23 Jan 2018 13:28:20 -0800
Subject: [PATCH v1 2/2] drm/bridge/synopsys: dsi: Add a warning msg on dsi
 read operations
In-Reply-To: <20180123142618.28384-3-philippe.cornu@st.com>
References: <20180123142618.28384-1-philippe.cornu@st.com>
 <20180123142618.28384-3-philippe.cornu@st.com>
Message-ID: <CA+ASDXPJ9uPDwRhP2WbazjeT6o=6L0ttffWXjwjkD3KxB+1cuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

I see you sent this out already today, while I only just responded
(late) to your questions about it... oh well :)

On Tue, Jan 23, 2018 at 6:26 AM, Philippe Cornu <philippe.cornu@st.com> wrote:
> The DCS/GENERIC DSI read feature is not yet implemented so it
> is important to warn the host_transfer() caller in case of
> read operation requests.
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index 096cf5e5bb30..e46ddff8601c 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -417,7 +417,14 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>         if (ret)
>                 return ret;
>
> -       nb_bytes = packet.size;
> +       if (msg->rx_buf && msg->rx_len > 0) {

It feels like you should do this check *before* you start writing
anything. It's possible to have a combination TX/RX command, and it
would be counterintuitive to only do half the operation then return
with an argument error.

> +               /* TODO dw drv improvements: implement read feature */
> +               dev_warn(dsi->dev, "read operations not yet implemented\n");
> +               return -EPERM;

I'm not sure -EPERM is right. Feels like -EINVAL, -ENOSYS, or
-EOPNOTSUPP. I think -ENOSYS actually has been abused somewhat, so
maybe one of the other two.

> +

Spurious blank line?

> +       } else {
> +               nb_bytes = packet.size;
> +       }

You don't actually need to put this sort of thing in the 'else' case.
The other branch is an error-handling case, which definitely 'return's
early, and it's pretty standard coding style to avoid indenting the
"good" path like this.

Brian

>
>         return nb_bytes;
>  }
> --
> 2.15.1
>
