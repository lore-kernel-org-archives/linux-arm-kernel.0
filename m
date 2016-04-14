From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 14 Apr 2016 10:52:43 +0200
Subject: [PATCH 3/6] ARM: PSCI: Register with kernel restart handler
In-Reply-To: <20160414004223.GA18564@roeck-us.net>
References: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
 <1460120039-2497-4-git-send-email-linux@roeck-us.net>
 <20160413110519.GE32018@leverpostej>
 <570E4550.5000207@roeck-us.net>
 <CAMuHMdU+vj4HDTLdXngUsTjF-Ki-HtbhoRU6mV7UKCz-BhFAtQ@mail.gmail.com>
 <20160414004223.GA18564@roeck-us.net>
Message-ID: <20160414085242.GB1533@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> That makes things quite tricky. Best I can think of is a series of boolean
> devicetree properties, such as
> 
> 	broken-reset-handler
> 	last-resort-restart-handler
> 	secondary-restart-handler
> 	default-restart-handler
> 	primary-restart-handler
> 
> which ends up being quite similar to the 'restart-priority' property. I'll
> do this as follow-up patch, though

Please CC me on this. I wanted to tackle this problem as well today. My
findings/conclusions so far:

* There is one driver bringing 'priority' directly to DT already: gpio-restart

* Watchdog priorities are board dependant

* Having the priorities clear at boot-time is safer than configuring them
  at run-time

* The linux scheme (0-255) shouldn't be enforced in DT

So, I wondered about a "priority" binding which just states "the higher,
the more important". Then any OS can decide what to do with it. In the
Linux case, this could be: sort them and give them priority 256 -
position_in_sorted_list.

Opinions?

> - I do not see the point holding up the series for this, and it is
> really a separate problem.

Ack.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160414/86dea876/attachment-0001.sig>
