From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 21 Jun 2017 19:12:28 +0800
Subject: [PATCH v2] KVM: arm/arm64: Signal SIGBUS when stage2 discovers
 hwpoison memory
In-Reply-To: <594A4205.70201@arm.com>
References: <20170524163250.29281-1-james.morse@arm.com>
 <3dbafd74-57f2-e724-ace2-0f84abb57e59@huawei.com> <594A4205.70201@arm.com>
Message-ID: <3bcc724d-0aaf-3384-fc75-38c224f604ed@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi james

On 2017/6/21 17:53, James Morse wrote:
> What happens if HPFAR_EL2 isn't set when this kind of error occurs?
> Provided EL3 can learn the physical address that triggered the exception then
> for firmware-first this isn't a problem. These errors should be taken to EL3 and
> then described by CPER records to the OS. The OS should process the CPER records
> in preference to attempting 'kernel first error handling'

here the pfn is from the HPFAR_EL2, not from the CPER record, which does not related with the CPER records.
Although OS can process the CPER records, but here the pfn may be always zero.
+	if (pfn == KVM_PFN_ERR_HWPOISON) {
+		kvm_send_hwpoison_signal(hva, vma);
+		return 0;
+	}
