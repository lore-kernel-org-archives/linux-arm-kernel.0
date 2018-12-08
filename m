Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A1CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:50:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE21520868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ESG/SsZG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiyE8hW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE21520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n238b+H0Fanbi2i5dbdUnJ5i7Y7hvbVLE7XVPFuPEDY=; b=ESG/SsZGJGl8hO
	BcCd/P09grqtM5Y6cyBruLSHBofdser+fhuhdDsKsLuCA7xTm3Y/SChXVR7GMvZpHYF8Ca7vrpvrh
	Ch8XsU0s1J/LkprPQJHgv4QCnwHORArVJ7Z9vqIUIsL2HEnGGv16pje3TYegD5szj1kkaklPPZkrL
	RnNnUe/1u+EpOAV/cGFmzCW99+GhxzLk/M+Wt0uXGVII9RDFDNnyiLuwTYBkut+ar09CUPyCoDDco
	uccqmOPorixnsiMaeRmo09S9bQFYy+SAKamalZma1H+xIXfFGXTAG+hRGzzAJFx8ZjpYwRftrvb6h
	aqIfk82Nng9UCOoyZwdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVYJo-00015j-Vd; Sat, 08 Dec 2018 08:50:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVYJi-00015P-Sq
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 08:50:35 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1670220868;
 Sat,  8 Dec 2018 08:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544259020;
 bh=M9cp6RjjQzFdzfvO48Y5bYLVWXp5VvDntuWpAidNAX4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DiyE8hW5FemQl9gwqoI7DOoIv9uIEzJIN3N/6cAz1f/wdn9xgFPgWbReoj7LcJpX0
 M+HSVETgaW4aaRAY7dOlsYC0mTdzahzMzbdPRsjDsIrYOxCpuVQk209Rm4Uw2qoS8M
 caLQUZZ5HPiiR3v1RMip/7Folsck3Xp6uKaPQb6s=
Date: Sat, 8 Dec 2018 09:50:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Message-ID: <20181208085016.GA20795@kroah.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
 <4f7a4211-47ee-1114-0974-a3b402178106@kapsi.fi>
 <CABb+yY3_uWv1YVxXxjgygPemBZraCTAXNyXT9G4aTMZv1t7d0g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABb+yY3_uWv1YVxXxjgygPemBZraCTAXNyXT9G4aTMZv1t7d0g@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_005030_961666_443827E5 
X-CRM114-Status: GOOD (  20.17  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Devicetree List <devicetree@vger.kernel.org>,
 Mikko Perttunen <cyndis@kapsi.fi>, mliljeberg@nvidia.com,
 Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com,
 Thierry Reding <thierry.reding@gmail.com>, linux-serial@vger.kernel.org,
 jslaby@suse.com, linux-tegra@vger.kernel.org, ppessi@nvidia.com,
 Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 08, 2018 at 11:21:41AM +0530, Jassi Brar wrote:
> On Fri, Dec 7, 2018 at 11:50 AM Mikko Perttunen <cyndis@kapsi.fi> wrote:
> >
> > On 07/12/2018 11.26, Jassi Brar wrote:
> > >> I thought that I could also mitigate 2) by busy looping in the TCU driver,
> > >> but it turns out that that doesn't work. The reason is that since we are
> > >> in atomic context with all interrupts disabled, the mailbox won't ever
> > >> consume any new characters, so the read pointer in the circular buffer
> > >> won't increment, leaving me with no condition upon which to loop that
> > >> would work.
> > >>
> > > So you want to be able to rely on an emulated console (running on a
> > > totally different subsystem) to dump development-phase early-boot
> > > logs? At the cost of legitimizing busy looping in atomic context - one
> > > random driver messing up the api for ever. Maybe you could have the
> > > ring buffer in some shmem and only pass the number of valid characters
> > > in it, to the remote?
> > >
> >
> > I would like to note that this is the one and only console interface
> > that exists on these systems, for both development phase and production.
> > Other UARTs are not externally accessible on the systems, or they are
> > comparatively difficult to access as they aren't intended to be used as
> > consoles in the system design.
> 
> > The combination of hardware and firmware
> > implementing the console is black box from software's point of view
> > (similarly to any other UART HW). The interface has also been fixed at
> > an early system design phase, as there are many operating systems
> > running on these boards, each with their own drivers.
> >
> That is the saddest part - someone, who writes test cases for the h/w
> team and with almost no knowledge of how OSes work, decides how the
> firmware is going to work and calls it done. Then the Linux is left to
> deal with the mess as we "can't do anything about it".

That is totally normal, and is how hardware has been almost _always_
been designed and implemented.  Nothing new here at all, it's just the
life us kernel developers get used to very quickly as it is our job to
make that hardware work and appear to userspace as something sane and
universal.

Sorry,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
