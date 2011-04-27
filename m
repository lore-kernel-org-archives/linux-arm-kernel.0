From: andreiw@motorola.com (Andrei Warkentin)
Date: Tue, 26 Apr 2011 19:27:57 -0500
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <20110426225818.GD5832@shareable.org>
References: <201104122052.17453.pwaechtler@mac.com>
	<BANLkTin0NMo7ZDrnTmBghYeRC9wxJu7zrw@mail.gmail.com>
	<20110412203303.GA16019@shareable.org>
	<20110418135243.GB1479@ucw.cz>
	<20110418170752.GQ16019@shareable.org>
	<20110422154344.GA7526@ucw.cz>
	<BANLkTimZZEr8fqXbuBjpYxF1quBFv7Oihg@mail.gmail.com>
	<BANLkTikNqO_xGgsUrZ2fid4ZmA8P6AoHLA@mail.gmail.com>
	<BANLkTi=Zn+kDfErZN6tm6yxHTt4v6o7XNw@mail.gmail.com>
	<20110426225818.GD5832@shareable.org>
Message-ID: <BANLkTikcsJxvJAPMigvXXzbKdXsDEdeTXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2011 at 5:58 PM, Jamie Lokier <jamie@shareable.org> wrote:
>>
>> Reliable writes are exposed via REQ_FUA.
>
> Are you sure that's appropriate?
>
> Unless I have misunderstood (very possible), REQ_FUA means writes hit
> non-volatile storage before acknowledgement, not that they are atomic.
> I think the normal users of REQ_FUA don't require or expect large
> atomic writes; they use it as a shortcut for (write & flush this
> write) without implying anything else is flushed.

I would agree with you that it's not the best mapping. However, a failed
MMC write transaction has other properties. If I understand correctly,
depending on mode of failure (say pulling power), you might wind up
with extra data getting erased (because erase
happens at erase unit boundary), and erase can be done before all the
data was transferred from host to card.

The connection I made between FUA and reliable writes, is that you
were guaranteed "physical presence" of the written data on
storage medium as long as the transaction went through successfully. I
can see where I assumed more than I should have.... If that's not the
correct interpretation I will change it.

REQ_META doesn't sound like the right candidate, because it's
enforcing policy. Should there be a REQ_ATOMIC request type?

A
