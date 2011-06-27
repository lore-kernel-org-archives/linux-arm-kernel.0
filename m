From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 27 Jun 2011 17:35:49 -0600
Subject: [RFC 1/8] drivers: add generic remoteproc framework
In-Reply-To: <20110627232903.GB7736@n2100.arm.linux.org.uk>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-2-git-send-email-ohad@wizery.com>
	<20110627204958.GB20865@ponder.secretlab.ca>
	<20110627232903.GB7736@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=MDSuiGb64Se1T7zCWG6syxXbhTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 5:29 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 27, 2011 at 02:49:58PM -0600, Grant Likely wrote:
>> > +struct {
>> > + ? ? ?char magic[4] = { 'R', 'P', 'R', 'C' };
>> > + ? ? ?u32 version;
>> > + ? ? ?u32 header_len;
>> > + ? ? ?char header[...] = { header_len bytes of unformatted, textual header };
>> > + ? ? ?struct section {
>> > + ? ? ? ? ?u32 type;
>> > + ? ? ? ? ?u64 da;
>> > + ? ? ? ? ?u32 len;
>> > + ? ? ? ? ?u8 content[...] = { len bytes of binary data };
>> > + ? ? ?} [ no limit on number of sections ];
>> > +} __packed;
>>
>> Other have commented on the image format, so I'll skip this bit other
>> than saying that I agree it would be great to have a common format.
>
> (Don't have the original message to reply to...)
>
> Do we really want to end up with header being 5 bytes, header_len set
> as 5, and having to load/store all this data using byte loads/stores ?
>
> If we don't want that, then I suggest we get rid of the packed attribute,
> and require stuff to be naturally aligned.
>
> First issue is that struct section could be much better layed out:
>
> struct section {
> ? ? ? ?u32 type;
> ? ? ? ?u32 len;
> ? ? ? ?u64 da;
> ? ? ? ?u8 content[];
> };
>
> and require sizeof(struct section) % sizeof(u64) == 0 - iow, to find
> the next section, round len up to sizeof(u64). ?Ditto for the header.

Hopefully this will all be moot since it has been proposed to use elf
images directly.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
