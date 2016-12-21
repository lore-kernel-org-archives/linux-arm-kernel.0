From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Dec 2016 09:21:59 +0000
Subject: [PATCH 1/1] mm: call force_sig_info before prints
In-Reply-To: <20161221055911epcms5p1146cee9212cc17fa8d5b18c49a085def@epcms5p1>
References: <1482143832-11158-1-git-send-email-maninder1.s@samsung.com>
 <CGME20161219110753epcas3p1e2a8b5ce7bd4b4e26345f28ae803d72b@epcas3p1.samsung.com>
 <20161221055911epcms5p1146cee9212cc17fa8d5b18c49a085def@epcms5p1>
Message-ID: <20161221092158.GT14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is unreadable.  Sorry.

On Wed, Dec 21, 2016 at 05:59:11AM +0000, AMIT NAGAL wrote:
> <HTML><HEAD>
> <META content="text/html; charset=utf-8" http-equiv=Content-Type>
> <STYLE id=mysingle_style type=text/css>.search-word {
> 	BACKGROUND-COLOR: #ffee94
> }
> P {
> 	MARGIN-BOTTOM: 5px; FONT-SIZE: 10pt; FONT-FAMILY: Arial, arial; MARGIN-TOP: 5px
> }
> TD {
> 	MARGIN-BOTTOM: 5px; FONT-SIZE: 10pt; FONT-FAMILY: Arial, arial; MARGIN-TOP: 5px
> }
> LI {
> 	MARGIN-BOTTOM: 5px; FONT-SIZE: 10pt; FONT-FAMILY: Arial, arial; MARGIN-TOP: 5px
> }
> BODY {
> 	FONT-SIZE: 10pt; FONT-FAMILY: Arial, arial
> }
> </STYLE>
> 
> <META content=IE=5 http-equiv=X-UA-Compatible>
> <META content=IE=5 http-equiv=X-UA-Compatible>
> <STYLE id=knox_style type=text/css>P {
> 	MARGIN-BOTTOM: 5px; FONT-SIZE: 10pt; FONT-FAMILY: Arial, arial; MARGIN-TOP: 5px
> }
> </STYLE>
> 
> <META content=IE=5 http-equiv=X-UA-Compatible>
> <META name=GENERATOR content="MSHTML 11.00.9600.18500"></HEAD>
> <BODY>
> <P></P>
> <P>Hello,</P><PRE>On Mon, Dec 19, 2016 at 04:07:12PM +0530, Maninder Singh wrote:
> &gt;&gt; prints can delay queuing of signal, so better to print
> &gt;&gt;after force_sig_info.
> &gt;&gt; 
> &gt;&gt; Let's say process generated SIGSEGV , and some other thread sends
> &gt;&gt; SIGKILL to crashing process and it gets queued before SIGSEGV becuase
> &gt;&gt; of little delay due to prints so in this case coredump might not generate.
> 
> &gt; In any case, that's going to be a race - you can't predict exactly when
> &gt; the "other thread" will send the SIGKILL in relation to the SIGSEGV.
> 
> &gt; So, I don't see the point of this change.</PRE><PRE>Actually SIGSEGV queueing gets delayed in __do_user_fault as logs are printed first(show_pte , show_regs).</PRE><PRE>meanwhile if SIGKILL gets queued , SIGSEGV wont be serviced first and coredump will be skipped . </PRE><PRE>so our intention is to queue the SIGSEGV as early as possible . so that the probability of race between</PRE><PRE>SIGKILL and SIGSEGV can be minimized .</PRE><PRE>Amit</PRE><PRE>&nbsp;</PRE><table id=bannersignimg><tr><td><div id="cafe-note-contents" style="margin:10px;font-family:Arial;font-size:10pt;"><p>&nbsp;</p></div></td></tr></table><table id=confidentialsignimg><tr><td><div id="cafe-note-contents" style="margin:10px;font-family:Arial;font-size:10pt;"><p><img unselectable="on" data-cui-image="true" style="display: inline-block; border: 0px solid; width: 520px; height: 144px;" src="cid:cafe_image_0@s-core.co.kr"><br></p></div></td></tr></table></BODY></HTML><img src='http://ext.samsung.net/mail/ext/v1/external/status/update?userid=amit.nagal&do=bWFpbElEPTIwMTYxMjIxMDU1OTExZXBjbXM1cDExNDZjZWU5MjEyY2MxN2ZhOGQ1YjE4YzQ5YTA4NWRlZiZyZWNpcGllbnRBZGRyZXNzPWxpbnV4QGFybWxpbnV4Lm9yZy51aw__' border=0 width=0 height=0 style='display:none'>


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
