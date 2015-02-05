From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Feb 2015 13:50:37 +0000
Subject: [PATCH 2/4] rtc: sa1100: convert to run-time register mapping
In-Reply-To: <CAL_JsqLiiKvzxQqE=bEx7qoLSZXLZOegt87A=+pR3PJuSBK95w@mail.gmail.com>
References: <1423005775-26457-1-git-send-email-robh@kernel.org>
 <1423005775-26457-3-git-send-email-robh@kernel.org>
 <87h9v1a8k2.fsf@free.fr>
 <CAL_JsqLiiKvzxQqE=bEx7qoLSZXLZOegt87A=+pR3PJuSBK95w@mail.gmail.com>
Message-ID: <20150205135037.GP8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 07:34:50AM -0600, Rob Herring wrote:
> > And just for your information, both rtc-sa1100 and rtc-pxa can be used at the
> > same time in a pxa kernel.
> 
> Yes, I know. I find that a bit odd. We'll have a bit of a problem
> supporting that with DT BTW.

I think you're close to that problem without DT anyway.  You modify
rtc-sa1100 to use devm_ioremap_resource(), which claims the memory
resource exclusively, thus marking the memory region exclusive.

Luckily, rtc-pxa uses devm_ioremap() without claiming the memory
resource - which is the only saving grace for why it still works.
If rtc-pxa were to be converted to use devm_ioremap_resource(), then
they'll become mutually exclusive.

Also note that by including the resource in rtc-sa1100's platform
device resource list, you'll have stacked resources between the two
platform devices appearing in /proc/iomem (you did look at that
before posting the patches, right?)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
