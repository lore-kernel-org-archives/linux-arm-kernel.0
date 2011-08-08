From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 8 Aug 2011 09:39:35 +0530
Subject: [RFC] using amba_pl08x driver for s3c64xx SoCs
In-Reply-To: <CAGOxZ53edhKA=VbhJJKG--LoG6P8Y+ubKdH5-4woDgBEbTdtVQ@mail.gmail.com>
References: <CAGOxZ50Rz3ynmkuoJb9Pgc0b1pG++-CB9kUtU92zKYtfP3jtRg@mail.gmail.com>
	<CACRpkdasYKx8C7fR1heiQDnJgJMvLa1VuQNhQ+gu5F6ea7d3oA@mail.gmail.com>
	<CAGOxZ53edhKA=VbhJJKG--LoG6P8Y+ubKdH5-4woDgBEbTdtVQ@mail.gmail.com>
Message-ID: <4E3F617F.3070508@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2011 04:40 PM, Alim Akhtar wrote:
>>> >> @@ -1953,7 +2048,7 @@ static int pl08x_probe(struct amba_device *adev,
>>> >> const struct amba_id *id)
>>> >>                spin_lock_init(&ch->lock);
>>> >>                ch->serving = NULL;
>>> >>                ch->signal = -1;
>>> >> -               dev_info(&adev->dev,
>>> >> +               dev_dbg(&adev->dev,
>>> >>                         "physical channel %d is %s\n", i,
>>> >>                         pl08x_phy_channel_busy(ch) ? "BUSY" : "FREE");
>>> >>        }
>> >
>> > Check Russells and Vireshs recent patches, I think they have already
>> > fixed up a lot of debug prints.

Yes I already updated this to dev_dbg in my patchset.

> I have a concern here, let say if the dev_dbg is enabled, first call
> to pl08x_phy_channel_busy() with ch->serving=NULL will give me NULL
> pointer dereferencing crash.
> please see pl08x_phy_channel_busy() definition.

Sorry, but i couldn't get why will we get a crash here.

pl08x_phy_channel_busy() looks like this:

static int pl08x_phy_channel_busy(struct pl08x_phy_chan *ch)
{
	unsigned int val;

	val = readl(ch->base + PL080_CH_CONFIG);
	return val & PL080_CONFIG_ACTIVE;
}

ch->base is already initialized and clock is enabled by amba layer.

Sorry if I am missing something Obvious.

-- 
viresh
