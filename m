From: hrhaan@gmail.com (Harro Haan)
Date: Thu, 25 Mar 2010 13:03:28 +0100
Subject: [patch v3 2/3] at91_udc HW glitch
In-Reply-To: <cd73a99e1003231326r7623bbc0icba163f9b2e0e96e@mail.gmail.com>
References: <20100203143736.564974126@gmail.com>
	<20100203143803.528679118@gmail.com>
	<cd73a99e1003231326r7623bbc0icba163f9b2e0e96e@mail.gmail.com>
Message-ID: <6681f8e11003250503k20efc864ve6d916ad5a7c67b2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 March 2010 21:26, Andrew Victor <avictor.za@gmail.com> wrote:
>
> hi,
>
>
> I see in the data-sheet (SAM9261 / SAM9263), the following for the
> UDP_ CSRx registers:
>
> "WARNING: Due to synchronization between MCK and UDPCK, the software
> application must wait for the end of the write
> operation before executing another write by polling the bits which
> must be set/cleared."
>
> //! Clear flags of UDP UDP_CSR register and waits for synchronization
> #define Udp_ep_clr_flag(pInterface, endpoint, flags) { \
> ? ?while (pInterface->UDP_CSR[endpoint] & (flags)) \
> ? ? ? ?pInterface->UDP_CSR[endpoint] &= ~(flags); \
> ? ? }
> //! Set flags of UDP UDP_CSR register and waits for synchronization
> #define Udp_ep_set_flag(pInterface, endpoint, flags) { \
> ? ?while ( (pInterface->UDP_CSR[endpoint] & (flags)) != (flags) ) \
> ? ? ? pInterface->UDP_CSR[endpoint] |= (flags); \
> ? ?}
>
> The at91_udc driver does not seem to do that for its CSR register writes.
> So I was wondering if we implement what the datasheet says, would we
> still need the "fix" above.
>
>
> Regards,
> ?Andrew Victor

According to the following post it did not solve the problem:

"There are references to syncronization issues between clock domains
in documentation and source code. These references describe required
delays when setting or clearing bits in CSR until the bit actually
changes and the required delays between writing CSR and reading the
data register. Incorporating the delays suggested in datasheet to code
did not change anything, so I dug deeper."
source:
http://lists.arm.linux.org.uk/lurker/message/20090325.150843.f515c02f.en.html

I did not test this myself, maybe Anti Sullin can give more details.

Regards,

Harro Haan

BTW: same message, but now in plain text.
