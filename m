From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Wed, 28 Sep 2011 17:24:25 +0530
Subject: [PATCH V2 1/1] dmaengine/amba-pl08x: Add support for s3c64xx DMAC
In-Reply-To: <4E82EEE1.3020706@st.com>
References: <1317189007-23033-1-git-send-email-alim.akhtar@samsung.com>
	<1317189007-23033-2-git-send-email-alim.akhtar@samsung.com>
	<4E82D0A1.8050203@st.com>
	<CAGOxZ53qZy+VUM65oK68W088QR=RgQ=cNxOCbO7_WESJesJaVQ@mail.gmail.com>
	<4E82EEE1.3020706@st.com>
Message-ID: <CAGOxZ535KHUp6An2br0scU9HvCmg4OsnfCj7hWYq4iy+OEpO2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 3:24 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> On 9/28/2011 2:20 PM, Alim Akhtar wrote:
>> The main difference between Primecell PL080 and samsung variant is in
>> LLI control register bit [0:11] is reserved in case of samsung pl080
>> and one extra register is add to hold the transfer size at offset
>> 0x10. The purpose of cctl1 is store the transfer_size.
>
> So, actually you need to modify pl08x_fill_lli_for_desc() and
> pl08x_cctl_bits() routines.
>
I did Modified pl08x_cctl_bits(), but for some reason i reverted it back.
what i was doing something like returning just __retbits__ instead of
retbits |= tsize << PL080_CONTROL_TRANSFER_SIZE_SHIFT;
and doing the below for the __non-s3c__ controllers in the
pl08x_fill_lli_for_desc().
cctl |= 1 << PL080_CONTROL_TRANSFER_SIZE_SHIFT;
pl08x_fill_lli_for_desc(&bd, num_llis++, 1, cctl);

Do you think that will help?
basically i need to extract transfer_size from the cctl and write back
to the cctl1.

> Updating cctl1 on the last lli will not solve your purpose,
> and transfers needing more than one lli will fail.
> BTW, did you try testing your patch for more than one LLI.
>
point taken, i was testing with max 4095 bytes of data, which needs a
single LLI.

> --
> viresh
>
