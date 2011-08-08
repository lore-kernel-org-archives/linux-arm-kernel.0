From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Mon, 8 Aug 2011 10:21:53 +0530
Subject: [RFC] using amba_pl08x driver for s3c64xx SoCs
In-Reply-To: <4E3F6550.6010204@st.com>
References: <CAGOxZ50Rz3ynmkuoJb9Pgc0b1pG++-CB9kUtU92zKYtfP3jtRg@mail.gmail.com>
	<CACRpkdasYKx8C7fR1heiQDnJgJMvLa1VuQNhQ+gu5F6ea7d3oA@mail.gmail.com>
	<CAGOxZ53edhKA=VbhJJKG--LoG6P8Y+ubKdH5-4woDgBEbTdtVQ@mail.gmail.com>
	<CACRpkdaYxbgqYZZSgRJmfBDWPyp-SQrviK50UvHrkTCO=B=6NQ@mail.gmail.com>
	<4E3F6550.6010204@st.com>
Message-ID: <CAGOxZ51TcNcC9gAVbuv6DTpj7SXCNbf+r+DjjByi20SYPj-zmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 8, 2011 at 9:55 AM, viresh kumar <viresh.kumar@st.com> wrote:
> On 08/05/2011 06:49 PM, Linus Walleij wrote:
>> Alter pl08x_phy_channel_busy() to return false immediately if
>> ch->serving == NULL?
>>
>> Please make a separate patch for this, since it's an obvious bug that
>> should be fixed ASAP.
>
> On 08/08/2011 09:39 AM, viresh kumar wrote:
>> Sorry, but i couldn't get why will we get a crash here.
>>
>> pl08x_phy_channel_busy() looks like this:
>>
>> static int pl08x_phy_channel_busy(struct pl08x_phy_chan *ch)
>> {
>> ? ? ? unsigned int val;
>>
>> ? ? ? val = readl(ch->base + PL080_CH_CONFIG);
>> ? ? ? return val & PL080_CONFIG_ACTIVE;
>> }
>>
>> ch->base is already initialized and clock is enabled by amba layer.
>>
>> Sorry if I am missing something Obvious.
>
> Sorry, i saw your patch now only. So you have updated this routine and now
> occurs a new issue.
>
> @Linus: The bug isn't present currently, but is introduced with Alim's patch only.
> So probably he isn't required to send this change separately, but can include this
> in his patch only. What do you say?
>
yes, that is introduced by my patch only, and I have fixed like below:

static int pl08x_phy_channel_busy(struct pl08x_phy_chan *ch)
{
        struct pl08x_dma_chan *plchan = ch->serving;
        struct pl08x_driver_data *pl08x;
        unsigned int val;

        if(plchan == NULL)
                return false;

        pl08x = plchan->host;

        if(pl08x->vd->is_pl080_s3c)
                val = readl(ch->base + PL080S_CH_CONFIG);
        else
                val = readl(ch->base + PL080_CH_CONFIG);

        return val & PL080_CONFIG_ACTIVE;
}
> --
> viresh
>

Regards,
Alim
