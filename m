From: viresh.linux@gmail.com (viresh kumar)
Date: Fri, 29 Jul 2011 08:39:27 -0700
Subject: [PATCH 13/18] dmaengine/amba-pl08x: Align lli_len to
	max(src.width, dst.width)
In-Reply-To: <1311943427.1536.551.camel@vkoul-udesk3>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<afe9e5154d96c0f44c64c411c98b5db75969db6c.1311936524.git.viresh.kumar@st.com>
	<1311943427.1536.551.camel@vkoul-udesk3>
Message-ID: <CAOh2x==UpH0W+NWbGcXKhETwDWqigfhnij=JPBse-B-6ydcVUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/29/11, Koul, Vinod <vinod.koul@intel.com> wrote:
> On Fri, 2011-07-29 at 16:19 +0530, Viresh Kumar wrote:
>> Currently lli_len is aligned to min of two widths, which looks to be
>> incorrect.
>> Instead it should be aligned to max of both widths.
> hmmm, not sure I follow you...
> In previous patch you said
>
> "max_bytes_per_lli = bd.srcbus.buswidth *
> PL080_CONTROL_TRANSFER_SIZE_MASK;
> This is confirmed by ARM support guys."
>
> So why should lli_len be related to max of both widths?
>

Sorry if my commit log wasn't clear enough.
Actually there is a field in ctrl reg of channel: transfer_size (it is
max 4095),

total data to be transferred = srcwidth * value programmed in transfer_size.

Now, suppose we have to transfer 98 bytes with src width = HALF WORD
and dest width = WORD

then value to be programmed in transfer_size is 98 / 2 = 49

Now on the destination side, transfers will be word by word and so
after 24 transfers on dest and 48 on src, 96 bytes would be
transferred.

But for the last two bytes, we can read two bytes from src, but can't
transfer them to dest. As its width was 4.

That's why we need to have lli_len to be related to max of both widths?

--
viresh
