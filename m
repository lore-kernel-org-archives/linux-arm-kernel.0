From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 5 Nov 2014 02:11:22 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <20141104205117.GA17606@amd>
References: <20141104205117.GA17606@amd>
Message-ID: <20141105011122.GA30622@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Tue, Nov 04, 2014 at 09:51:17PM +0100, Pavel Machek wrote:
> I'd like to test a modem (and eventually to get it to work :-) ) on
> n900. So far I found:
> 
> http://lwn.net/Articles/592485/
> 
> It says:
> 
> # supported. Testing the patchset with ofono works like this:
> # 
> #  # provide cmt device for ofono
> #  ln -sf /sys/bus/hsi/n900-modem /dev/cmt
> 
> [...]
>
> That seemed to match, so I symlinked it.

looks ok. You should have the following files:

/dev/cmt/cmt_apeslpx
/dev/cmt/cmt_bsi
/dev/cmt/cmt_en
/dev/cmt/cmt_rst_rq
/dev/cmt/cmt_rst

Apart from that the kernel should be provide a phonet0
network device.

> #  # start ofono
> #  ofono --nodetach --debug
> 
> It it a typo and it wants ofonod?

yes.

> root at n900:~# ofonod --nodetach --debug &
> [1] 3552

no output from ofono?

> root at n900:~# mdbus2 -s org.ofono /n900_0 xyz
> [ERR]: There is no method with name xyz on path /n900_0!
>
> [...]
> 
> Any ideas?

call mdbus2 with fewer arguments to see what is available on the
bus:

mdbus2 -s                      => list all system services
mdbus2 -s org.ofono            => list all ofono objects
mdbus2 -s org.ofono /n900_0    => list all methods from n900 object

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/399324a5/attachment-0001.sig>
