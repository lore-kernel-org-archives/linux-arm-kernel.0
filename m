From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 26 Mar 2013 11:28:11 +0100
Subject: [PATCH V2] Sound: sgtl5000 Allow codec clock frequency to be set.
In-Reply-To: <CAOZdJXWi2pph-=vQg+FAty+yVVk9fJBU6rxYOf0J-J2f=Lwgxw@mail.gmail.com>
References: <20130322093344.20605.49509.stgit@localhost>
 <CAOZdJXWi2pph-=vQg+FAty+yVVk9fJBU6rxYOf0J-J2f=Lwgxw@mail.gmail.com>
Message-ID: <5151783B.7050105@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/03/13 15:08, Timur Tabi wrote:
> On Fri, Mar 22, 2013 at 4:33 AM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:
>
>> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
>> index 424347e..71ce1f6 100644
>> --- a/sound/soc/fsl/imx-sgtl5000.c
>> +++ b/sound/soc/fsl/imx-sgtl5000.c
>> @@ -128,18 +128,30 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>>                  goto fail;
>>          }
>>
>> +       ret = of_property_read_u32(codec_np, "clock-frequency",
>> +                                       &data->clk_frequency);
> I just noticed that you assign 'ret' here, but you never check the
> value.  So I think you should either:
>
> 1) Check the value of 'ret'
> 2) Remove the "ret = "
Initially I did check the value of 'ret', instead of checking 
data->clk_frequency.

However I found that checking a generic return variable 'ret' several 
lines later
to be not very clear (to see what 'ret' refers to you have to backtrack 
while
reading the code).

The ret can't be checked directly after assigning it as it's not always 
an error
condition (in the phandle only case an error here is normal).

Checking data->clk_frequency, IMHO makes the code more readable.

If I remove the "ret ="  no error code will be propagated back to the 
caller.
Sure I could add an assignment of ret to -EINVAL in the error case like 
this:


     of_property_read_u32(codec_np, "clock-frequency",
                     &data->clk_frequency);
     data->codec_clk = clk_get(&codec_dev->dev, NULL);

     if (IS_ERR(data->codec_clk)) {
         /* assuming clock enabled by default (frequency required) */
         data->codec_clk = NULL;
         if (!data->clk_frequency) {
             dev_err(&codec_dev->dev,
                 "clock-frequency missing or invalid\n");
             ret = -EINVAL;
             goto fail;
         }
     } else {


But I don't think this is better than just propating the value from 
of_property_read_u32()
as it loses information.

Martin
