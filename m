From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 10:46:51 +0000
Subject: [PATCH v2 06/10] drivers: PL011: replace UART_MIS reading with
 _RIS & _IMSC
In-Reply-To: <1425491994-23913-7-git-send-email-andre.przywara@arm.com>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
 <1425491994-23913-7-git-send-email-andre.przywara@arm.com>
Message-ID: <20150312104651.GJ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 05:59:50PM +0000, Andre Przywara wrote:
> The PL011 register UART_MIS is actually a bitwise AND of the
> UART_RIS and the UART_MISC register.
> Since the SBSA UART does not include the _MIS register, use the
> two separate registers to get the same behaviour. Since we are
> inside the spinlock and we read the _IMSC register only once, there
> should be no race issue.

Do we really need to go all the way to the hardware for this?  Isn't
uap->im sufficient?  Reading from memory is potentially faster as it
could be in the CPU caches.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
