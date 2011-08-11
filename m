From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Aug 2011 14:55:39 +0200
Subject: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
In-Reply-To: <CABb+yY2Usd5=RW6BV69UW=Tq0zQW6LCtT2GhfdHGA61ZU3aNcQ@mail.gmail.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
	<CABb+yY3SnqKN78U7vLbom1i00m=ThnRVQDVM_iX1TPu=+XzSNQ@mail.gmail.com>
	<20110810104025.GK1831@n2100.arm.linux.org.uk>
	<CABb+yY3=q5Nq1wtM6Av2DrgUfjZR_Ao40QhBhv_ik9naAd5wRg@mail.gmail.com>
	<CACRpkdaCyUJ3A9VWfsVuwJj3DGVkvjc2_ZOD4yM4YX3NPxAAYQ@mail.gmail.com>
	<CABb+yY2Usd5=RW6BV69UW=Tq0zQW6LCtT2GhfdHGA61ZU3aNcQ@mail.gmail.com>
Message-ID: <CAKnu2Mo=9wusKrc7DeL9fk-fq3pY1D3WKHXYmo+b9w5GbyzegA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/10 Jassi Brar <jassisinghbrar@gmail.com>:
> On Wed, Aug 10, 2011 at 5:24 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> Linus W, was there anything you said wouldn't work with the scheme ?
>>> Please tell now on the record.
>>
>> It would *work* but the current proposal is *not elegant* IMO.
>
> would *work* ?-> You could find no case that the scheme wouldn't support.

Well there is the usecase where we have a lot of devices, but it is
true we don't have that kind of hardware around.

> *not elegant* ?-> Your opinion. Let us see.

Well, yeah, such is life.

> Client having to specify the device it wants a channel for, is a
> waste - otherwise we don't fully get rid of platform assistance for
> channel selection!

I think I saw you proposal define REQ(MMC,2) for example,
isn't that specifying the device?

>> rxc = dma_request_slave_channel(dev, "MMC-RX");
>> txc = dma_request_slave_channel(dev, "MMC-TX");
>
> Absolutely "not-very-good" !
> We can do without the 'dev' argument.

You still need to pass in something referring you back to
the device.

> How does a client request duplex channel ?

Currently the duplex channels using DMA-engine switch
direction of the channel at runtime with the config call.0
There is a "bidirectional" define in dmaengine.h but I
haven't figured out if that is useful for slave transfers
at all really.

> Do you propose to implement a string parser in the core ?!

Yes, the clock and regulator framework already does that.
But it is only used when you cannot pass in a struct device *
directly, like from device tree.

>> I also recognized that you needed a priority scheme and
>> a few other bits for the above,
>
> You didn't recognize. I told you. IIRC you suggested I should actually
> sell that point!

http://en.wiktionary.org/wiki/recognise

   1. (transitive) To match something or someone which one currently
perceives to a memory of some previous encounter with the same entity.
   2. (transitive) To acknowledge the existence or legality of
something.; treat as worthy of consideration or valid.

          The US and a number of EU countries are expected to
recognise Kosovo on Monday.

   3. (transitive) To acknowledge or consider as something.
   4. (transitive) To realise or discover the nature of something;
apprehend quality in; realise or admit that.
   5. (transitive) To give an award.

Sorry for spelling with "z".

>> If the majority is happy with this scheme I can even
>> try implementing it.
>
> Interesting! Only a few days ago you were seeing eternal sunshine in
> filter-functions... and now you plan to implement my proposal by
> replacing bit-fields with strings.

Yes your argument for a better channel-lookup functionality
are perfectly valid, that is what I mean when I say I recognize
it. We only disagree on how to implement it.

As for eternal sunshine, well, it rains here in Sweden today
so the kernel is a pretty sunny place comparatively.

Thanks,
Linus Walleij
