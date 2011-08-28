From: ming.lei@canonical.com (Ming Lei)
Date: Sun, 28 Aug 2011 11:35:03 +0800
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <Pine.LNX.4.44L0.1108271607150.21403-100000@netrider.rowland.org>
References: <CACVXFVNrck4u3d7EaRwuwSVO9J-_0jDQ07U0PCw55FZUxsCszA@mail.gmail.com>
	<Pine.LNX.4.44L0.1108271607150.21403-100000@netrider.rowland.org>
Message-ID: <CACVXFVP_FbcUprZu5pxHqeTTy+eed3F_Lb8yrOg51n6WbwckKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Aug 28, 2011 at 4:11 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sun, 28 Aug 2011, Ming Lei wrote:
>
>> Looks like there is still another similar problem in qh_link_async():
>> the last wmb
>> should be changed into mb, because HC will read 'head->hw->hw_next' from qh
>> descriptor and this pointer in qh is read only for HC. But this problem can't be
>> observed on ARM, since wmb on ARM is same with mb.
>
> It doesn't matter what the HC does -- the wmb() instruction is executed
> by the CPU, not the HC. ?The point of that instruction is to make sure
> that the
>
> ? ? ? ?qh->hw->hw_next = head->hw->hw_next;
>
> line (and all the preceding lines as well) is ordered before the
>
> ? ? ? ?head->hw->hw_next = dma;
> 3C
> line. ?Since both of these lines are writes, not reads, it suffices to
> use wmb() rather than mb().

oops,  I added a wmb() after the line of 'head->hw->hw_next = dma;',
in my debug code, and not found that it is my local modification before
sending out last mail. (I described it as 'the last wmb' in fact), sorry for the
noise, please ignore it.

thanks,
--
Ming Lei
