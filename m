From: philippe.cornu@st.com (Philippe CORNU)
Date: Wed, 24 Jan 2018 13:22:04 +0000
Subject: [PATCH v1 2/2] drm/bridge/synopsys: dsi: Add a warning msg on dsi
 read operations
In-Reply-To: <CA+ASDXPJ9uPDwRhP2WbazjeT6o=6L0ttffWXjwjkD3KxB+1cuQ@mail.gmail.com>
References: <20180123142618.28384-1-philippe.cornu@st.com>
 <20180123142618.28384-3-philippe.cornu@st.com>
 <CA+ASDXPJ9uPDwRhP2WbazjeT6o=6L0ttffWXjwjkD3KxB+1cuQ@mail.gmail.com>
Message-ID: <369181f6-1bb4-0559-86c9-5528be7fc459@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,


On 01/23/2018 10:28 PM, Brian Norris wrote:
> Hi Philippe,
> 
> I see you sent this out already today, while I only just responded
> (late) to your questions about it... oh well :)
> 

I got a short period to clean-up and adds features to this driver (1.31 
ip version + maybe the read feature), sorry to have not wait a single 
day more.

> On Tue, Jan 23, 2018 at 6:26 AM, Philippe Cornu <philippe.cornu@st.com> wrote:
>> The DCS/GENERIC DSI read feature is not yet implemented so it
>> is important to warn the host_transfer() caller in case of
>> read operation requests.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> index 096cf5e5bb30..e46ddff8601c 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -417,7 +417,14 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>>          if (ret)
>>                  return ret;
>>
>> -       nb_bytes = packet.size;
>> +       if (msg->rx_buf && msg->rx_len > 0) {
> 
> It feels like you should do this check *before* you start writing
> anything. It's possible to have a combination TX/RX command, and it
> would be counterintuitive to only do half the operation then return
> with an argument error.
> 

Many thanks for your review.

I agree with your comments.

Well, my patch is not good at all because it contains a small part of 
the read feature I am writing... but it is not the purpose of this patch.

No excuse, sorry guys for making you waste time.

I will re-write a new patch 100% decorrelated from a possible future 
read feature.

I could also wait until I have a working read feature but as it could 
take some times, I prefer warning users asap.

>> +               /* TODO dw drv improvements: implement read feature */
>> +               dev_warn(dsi->dev, "read operations not yet implemented\n");
>> +               return -EPERM;
> 
> I'm not sure -EPERM is right. Feels like -EINVAL, -ENOSYS, or
> -EOPNOTSUPP. I think -ENOSYS actually has been abused somewhat, so
> maybe one of the other two.
> 

not easy to pick the right one. I will use -EINVAL.

>> +
> 
> Spurious blank line?
> 
thanks

>> +       } else {
>> +               nb_bytes = packet.size;
>> +       }
> 
> You don't actually need to put this sort of thing in the 'else' case.
> The other branch is an error-handling case, which definitely 'return's
> early, and it's pretty standard coding style to avoid indenting the
> "good" path like this.
> 
> Brian
> 

The else part is linked to my "read feature" too, sorry for that. I will 
do it simpler in next version.

Thank you,
Philippe :-)

>>
>>          return nb_bytes;
>>   }
>> --
>> 2.15.1
>>
