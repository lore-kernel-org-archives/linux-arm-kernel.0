From: philippe.cornu@st.com (Philippe CORNU)
Date: Wed, 24 Jan 2018 13:33:54 +0000
Subject: [PATCH v1 1/2] drm/bridge/synopsys: dsi: Fix dsi_host_transfer()
 return value
In-Reply-To: <CA+ASDXNDpmVdARLCD-A6nfADgmomuscpwekb8M-j=MFJhpeC4Q@mail.gmail.com>
References: <20180123142618.28384-1-philippe.cornu@st.com>
 <20180123142618.28384-2-philippe.cornu@st.com>
 <CA+ASDXNDpmVdARLCD-A6nfADgmomuscpwekb8M-j=MFJhpeC4Q@mail.gmail.com>
Message-ID: <4a1b0208-3187-2f08-69fe-ca3b77ee88a8@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

And many thanks for your review.

On 01/23/2018 10:38 PM, Brian Norris wrote:
> Hi Philippe,
> 
> On Tue, Jan 23, 2018 at 6:26 AM, Philippe Cornu <philippe.cornu@st.com> wrote:
>> The dw_mipi_dsi_host_transfer() must return the number of
>> bytes transmitted/received on success instead of 0.
> 
> I'm a little confused. As of the latest drm-misc-next I'm looking at,
> this still has conflicting documentation.
> 
> For ->transfer():
> 
> On success it shall return the number of bytes
>   * transmitted for write packets or the number of bytes received for read
>   * packets.
> 
> While mipi_dsi_generic_read() says:
> 
>   * Return: The number of bytes successfully read or a negative error code on
>   * failure.
> 
> But it just returns the value that ->transfer() returns.
> 

Not sure to follow you here: mipi_dsi_generic_read() will trig a dsi 
generic read so it has to return "the number of bytes received for read 
packets" as explained for the ->transfer() function... so it looks 
"coherent"...

But maybe you want to point out something different?

> So I'm not sure whether the documentation is still wrong, or if the
> implementation is.
> 
> Anyway, I guess maybe that isn't super-critical to *this* patch, since
> we don't have RX support yet...
> 

The main reason why I want to "fix" this is because I do not want to 
explain to our customers (writing dsi panel drivers) why we have a 
different returned value compare to other platforms : )

>> Note: nb_bytes is introduced in this patch as it will be
>> re-used with the future dcs/generic dsi read feature.
> 
> It feels like you could just wait to add that when you need it? It
> really feels trivial and useless right now :)
> 
> Brian
> 

Thanks, I agree, I will write & send a simpler version.
Philippe :-)

>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> index f458798af788..096cf5e5bb30 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -403,7 +403,7 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>>   {
>>          struct dw_mipi_dsi *dsi = host_to_dsi(host);
>>          struct mipi_dsi_packet packet;
>> -       int ret;
>> +       int ret, nb_bytes;
>>
>>          ret = mipi_dsi_create_packet(&packet, msg);
>>          if (ret) {
>> @@ -413,7 +413,13 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>>
>>          dw_mipi_message_config(dsi, msg);
>>
>> -       return dw_mipi_dsi_write(dsi, &packet);
>> +       ret = dw_mipi_dsi_write(dsi, &packet);
>> +       if (ret)
>> +               return ret;
>> +
>> +       nb_bytes = packet.size;
>> +
>> +       return nb_bytes;
>>   }
>>
>>   static const struct mipi_dsi_host_ops dw_mipi_dsi_host_ops = {
>> --
>> 2.15.1
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
